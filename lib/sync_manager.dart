import 'dart:async';

import 'package:drift_demo/drift/database.dart';

class SyncManager {

  SyncManager({ required this.queryExecutor });

  final Future<void> Function(Future<void> Function(DemoDatabase database) toExecute) queryExecutor;
  final _results = <Typed, List>{};
  final _depMap = <Typed, Set<SyncDependencyKey>>{};
  final _descriptors = <Typed, _SyncActionDescriptor>{};

  var _started = false;
  final _running = <Typed, Future>{};

  void add<CType>(Typed<CType> type, Set<SyncDependencyKey> dependsOn, SyncDependencyActionMethod<CType> method, {Set<Typed>? resolves}) {
    _checkStarted();
    resolves ??= { type };
    for (var dep in dependsOn) {
      final key = dep;
      final deps = _depMap[type] ?? {};
      _depMap[type] = { ...deps, key };
    }

    final _SyncActionDescriptor descriptor = (action: method, resolves: resolves);
    _descriptors[type] = descriptor;
  }

  Future<void> start() {
    _checkStarted();
    _started = true;

    final completed = queryExecutor((a) async {
      await _buildDependencyFuture(a)();
    });

    return completed;
  }

  void dispose() {
    _running.clear();
    _depMap.clear();
    _descriptors.clear();
  }


  Future<void> Function() _buildDependencyFuture(DemoDatabase db) {
    final executeStarter = Completer<void>();
    final executeFuture = executeStarter.future;

    final deps = _descriptors.entries.map((e) {
      final rec = e.toRecordNamed();

      final dependsOn = _depMap[e.key] ?? {};

      return (key: rec.key, value: dependsOn);
    }).toList()
      ..sort((a, b) => a.value.length.compareTo(b.value.length));

    if (deps.first.value.isNotEmpty) {
      throw Exception('Circular dependency detected');
    }

    // A map of Typed dependencies to their futures
    // Used to track when a dependency is completed for the next dependencies to start
    final futures = <Typed, Future<void>>{};

    while (deps.isNotEmpty) {
      final List<(Set<Typed>, Future<void>)> next = deps.removeWhereReturning((entry) {
        final (key: _, value: deps) = entry;
        if (deps.isEmpty) {
          return true;
        }

        return deps.every((dep) => futures.containsKey(dep.controllerType));
      })
          .map((entry) {
        final key = entry.key;
        final resolving = _descriptors[key]!.resolves;

        if (!_descriptors.containsKey(key)) {
          throw Exception('No starter found for $key');
        }

        // Creates a Future that is the result of waiting on all dependencies
        final depKeySet = _depMap[key];
        final starterFuture = depKeySet?.map((depKey) {
          return futures[depKey.controllerType]!;
        }).waitEagerError ?? executeFuture;

        final completer = Completer<void>();
        Future<void> runner() async {
          try {
            await _runType(db, key);
            _descriptors.remove(key); //Remove the descriptor so that updateProgress is accurate
            completer.complete();
          } catch (e, s) {
            completer.completeError(e, s);
          }
        }

        starterFuture.then(
                (_) => runner(),
            onError: (err, stack) => completer.completeError(err, stack)
        );

        return (resolving, completer.future);
      })
          .toList();

      if (next.isEmpty) {
        final found = futures.keys.join(', ');
        final unable = deps.map((e) {
          final key = e.key;
          final deps = e.value.map((e) => e.controllerType).join(', ');
          return '$key depends on $deps';
        }).join(';\n');
        throw Exception('Could not find starters to resolve.\nFound:\n$found.\nUnable to resolve:\n$unable');
      }

      for (final (keys, value) in next) {
        for (final key in keys) {
          futures[key] = value;
        }
      }
    }

    return () async {
      executeStarter.complete();
      final allComplete = await futures.values.toList().waitEagerError.then((_) => null);
      return allComplete;
    };

  }

  Future<void> _runType<CType>(DemoDatabase db, Typed<CType> type) async {
    final deps = _depMap[type] ?? {};
    final param = deps.fold(SyncDependencyActionMethodParameter(), (param, key) {
      param._results[key.controllerType] = [..._results[key.controllerType]!];
      return param;
    });

    final descriptor = _descriptors[type]!;

    final callback = descriptor.action;
    print('Starting $type');

    final List<SyncDependencyResult> results;
    if (param._results.keys.isNotEmpty && param._results.values.every((e) => e.isEmpty)) {
      print('Parameters for $type are empty. Skipping callback action.');
      results = descriptor.resolves.map((resolvingType) {
        return SyncDependencyResult.empty(type: resolvingType);
      }).toList();
    }
    else {
      results = await callback(db, param);
    }

    for (final expectedTypes in descriptor.resolves) {
      final result = results.firstWhereOrNull((e) => e.type == expectedTypes);
      if (result == null) {
        throw Exception('$type => Expected result for $expectedTypes not found');
      }
      _results[expectedTypes] = result.results;
    }

    for (final returnedTypes in results.map((e) => e.type)) {
      if (!descriptor.resolves.contains(returnedTypes)) {
        throw Exception('$type => Returned result for $returnedTypes not expected');
      }
    }

    for (final result in results) {
      _results[result.type] = result.results;
    }
  }


  void _checkStarted() {
    if (!_started) return;
    throw Exception('SyncManager is already running');
  }
}

class SyncDependencyActionMethodParameter {
  final _results = <Typed, List>{};

  List<TType> get<TType, CType>() {
    final key = SyncDependencyKey<TType, CType>();
    return key.get(this);
  }
}

class SyncDependencyKey<TType, CType> {
  final Typed<CType> controllerType;
  final Typed<TType> resultType;

  SyncDependencyKey(): this.of(
      controllerType: Typed<CType>(),
      resultType: Typed<TType>()
  );

  SyncDependencyKey.of({ required this.controllerType, required this.resultType });

  List<TType> get(SyncDependencyActionMethodParameter parameter) {
    final values = parameter._results[controllerType];
    if (values == null) throw Exception("Got null expected $resultType");
    return values.cast<TType>();
  }

  @override
  bool operator ==(Object other) {
    if (other is! SyncDependencyKey) return false;
    return controllerType == other.controllerType && resultType == other.resultType;
  }

  @override
  int get hashCode => Object.hash(TType, CType);
}

class SyncDependencyResult<TType, CType> {
  final Typed<CType> type;
  final List<TType> results;

  SyncDependencyResult.withType(this.results): type = Typed<CType>();
  SyncDependencyResult({required this.type, required this.results});
  SyncDependencyResult.empty({required this.type}): results = [];
}

typedef SyncDependencyActionMethod<T> = Future<List<SyncDependencyResult>> Function(DemoDatabase db, SyncDependencyActionMethodParameter parameter);
typedef _SyncActionDescriptor = ({Set<Typed> resolves, SyncDependencyActionMethod action});

extension _ListExtension<E> on List<E> {
  List<E> removeWhereReturning(bool Function(E) test) {
    final removed = <E>[];

    for (var i = length - 1; i >= 0; i--) {
      final entry = this[i];
      if (test(entry)) {
        removed.add(entry);
        removeAt(i);
      }
    }

    return removed;
  }

  firstWhereOrNull(bool Function(E val) test) {
    for (final val in this) {
      if (test(val)) return val;
    }

    return null;
  }
}

extension _IterableOfFutureExtension<E> on Iterable<Future<E>> {
  Future<List<E>> get waitEagerError {
    return Future.wait(this, eagerError: true);
  }
}

extension _MapEntryExtensions<T, E> on MapEntry<T, E> {
  ({T key, E value}) toRecordNamed() => (key: key, value: value);
}

extension type const Typed<T>._(Type _type) implements Type {
  const Typed(): this._(T);
  const Typed.of(T value): this._(T);
  const Typed.ofIterable(Iterable<T> iterable): this._(T);
}