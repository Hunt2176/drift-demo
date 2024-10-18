import 'package:drift_demo/mock_http.dart';
import 'package:drift_demo/drift/database.dart';
import 'package:drift_demo/sync_manager.dart';

void main() async {
  final db = DemoDatabase();
  final http = const MockHttp();

  final manager = SyncManager(queryExecutor: (toExecute) async {
    // Removing this transaction and running `toExecute` directly would prevent the deadlock
    return await db.transaction(() async {
      return toExecute(db);
    }, requireNew: true);
  });

  manager
    // Adding an action that does not depend on any other action
    ..add(const Typed<DemoDriftEntityA>(), {}, resolves: { const Typed<List<DemoDriftEntityA>>() }, (db, p) async {
      final data = await http.get();
      final results = await db.tableADao.insertFromHttp(data);
      return [
        SyncDependencyResult(type: const Typed<List<DemoDriftEntityA>>(), results: results)
      ];
    })
    // Adding a second action that depends on the first
    ..add(
        const Typed<DemoDriftEntityB>(),
        { SyncDependencyKey<List<DemoDriftEntityA>, List<DemoDriftEntityA>>() },
        resolves: { const Typed<List<DemoDriftEntityB>>() },
        (db, p) async {
          // Example use of getting the dependency
          final paraA = p.get<List<DemoDriftEntityA>, List<DemoDriftEntityA>>();

          final data = await http.get();
          final results = await db.tableBDao.insertFromHttp(data);

          return [
            SyncDependencyResult(type: const Typed<List<DemoDriftEntityB>>(), results: results)
          ];
        },
    )
    ..add(const Typed<Object>(),
        {
          SyncDependencyKey<List<DemoDriftEntityA>, List<DemoDriftEntityA>>(),
          SyncDependencyKey<List<DemoDriftEntityB>, List<DemoDriftEntityB>>()
        },
        resolves: {},
        (db, p) async {
          // Example use of getting the dependency
          final paraA = p.get<List<DemoDriftEntityA>, List<DemoDriftEntityA>>();
          final paraB = p.get<List<DemoDriftEntityB>, List<DemoDriftEntityB>>();

          // Do something with the dependencies
          return [];
        }
    );

  await manager.start();
}