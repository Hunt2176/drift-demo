// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DemoTableATable extends DemoTableA
    with TableInfo<$DemoTableATable, DemoDriftEntityA> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DemoTableATable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _externalIdMeta =
      const VerificationMeta('externalId');
  @override
  late final GeneratedColumn<int> externalId = GeneratedColumn<int>(
      'external_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, name, externalId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'table_a';
  @override
  VerificationContext validateIntegrity(Insertable<DemoDriftEntityA> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('external_id')) {
      context.handle(
          _externalIdMeta,
          externalId.isAcceptableOrUnknown(
              data['external_id']!, _externalIdMeta));
    } else if (isInserting) {
      context.missing(_externalIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DemoDriftEntityA map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DemoDriftEntityA(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      externalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}external_id'])!,
    );
  }

  @override
  $DemoTableATable createAlias(String alias) {
    return $DemoTableATable(attachedDatabase, alias);
  }
}

class DemoDriftEntityA extends EntityHasName
    implements Insertable<DemoDriftEntityA>, EntityHasExternalId {
  final int id;
  final String? name;
  final int externalId;
  DemoDriftEntityA({required this.id, this.name, required this.externalId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['external_id'] = Variable<int>(externalId);
    return map;
  }

  DemoTableACompanion toCompanion(bool nullToAbsent) {
    return DemoTableACompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      externalId: Value(externalId),
    );
  }

  factory DemoDriftEntityA.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DemoDriftEntityA(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      externalId: serializer.fromJson<int>(json['externalId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'externalId': serializer.toJson<int>(externalId),
    };
  }

  DemoDriftEntityA copyWith(
          {int? id,
          Value<String?> name = const Value.absent(),
          int? externalId}) =>
      DemoDriftEntityA(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        externalId: externalId ?? this.externalId,
      );
  DemoDriftEntityA copyWithCompanion(DemoTableACompanion data) {
    return DemoDriftEntityA(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      externalId:
          data.externalId.present ? data.externalId.value : this.externalId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DemoDriftEntityA(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('externalId: $externalId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, externalId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DemoDriftEntityA &&
          other.id == this.id &&
          other.name == this.name &&
          other.externalId == this.externalId);
}

class DemoTableACompanion extends UpdateCompanion<DemoDriftEntityA> {
  final Value<int> id;
  final Value<String?> name;
  final Value<int> externalId;
  const DemoTableACompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.externalId = const Value.absent(),
  });
  DemoTableACompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    required int externalId,
  }) : externalId = Value(externalId);
  static Insertable<DemoDriftEntityA> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? externalId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (externalId != null) 'external_id': externalId,
    });
  }

  DemoTableACompanion copyWith(
      {Value<int>? id, Value<String?>? name, Value<int>? externalId}) {
    return DemoTableACompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      externalId: externalId ?? this.externalId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (externalId.present) {
      map['external_id'] = Variable<int>(externalId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DemoTableACompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('externalId: $externalId')
          ..write(')'))
        .toString();
  }
}

class $DemoTableBTable extends DemoTableB
    with TableInfo<$DemoTableBTable, DemoDriftEntityB> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DemoTableBTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _externalIdMeta =
      const VerificationMeta('externalId');
  @override
  late final GeneratedColumn<int> externalId = GeneratedColumn<int>(
      'external_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, name, externalId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'table_b';
  @override
  VerificationContext validateIntegrity(Insertable<DemoDriftEntityB> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('external_id')) {
      context.handle(
          _externalIdMeta,
          externalId.isAcceptableOrUnknown(
              data['external_id']!, _externalIdMeta));
    } else if (isInserting) {
      context.missing(_externalIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DemoDriftEntityB map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DemoDriftEntityB(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      externalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}external_id'])!,
    );
  }

  @override
  $DemoTableBTable createAlias(String alias) {
    return $DemoTableBTable(attachedDatabase, alias);
  }
}

class DemoDriftEntityB extends EntityHasName
    implements Insertable<DemoDriftEntityB>, EntityHasExternalId {
  final int id;
  final String? name;
  final int externalId;
  DemoDriftEntityB({required this.id, this.name, required this.externalId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['external_id'] = Variable<int>(externalId);
    return map;
  }

  DemoTableBCompanion toCompanion(bool nullToAbsent) {
    return DemoTableBCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      externalId: Value(externalId),
    );
  }

  factory DemoDriftEntityB.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DemoDriftEntityB(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      externalId: serializer.fromJson<int>(json['externalId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'externalId': serializer.toJson<int>(externalId),
    };
  }

  DemoDriftEntityB copyWith(
          {int? id,
          Value<String?> name = const Value.absent(),
          int? externalId}) =>
      DemoDriftEntityB(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        externalId: externalId ?? this.externalId,
      );
  DemoDriftEntityB copyWithCompanion(DemoTableBCompanion data) {
    return DemoDriftEntityB(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      externalId:
          data.externalId.present ? data.externalId.value : this.externalId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DemoDriftEntityB(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('externalId: $externalId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, externalId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DemoDriftEntityB &&
          other.id == this.id &&
          other.name == this.name &&
          other.externalId == this.externalId);
}

class DemoTableBCompanion extends UpdateCompanion<DemoDriftEntityB> {
  final Value<int> id;
  final Value<String?> name;
  final Value<int> externalId;
  const DemoTableBCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.externalId = const Value.absent(),
  });
  DemoTableBCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    required int externalId,
  }) : externalId = Value(externalId);
  static Insertable<DemoDriftEntityB> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? externalId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (externalId != null) 'external_id': externalId,
    });
  }

  DemoTableBCompanion copyWith(
      {Value<int>? id, Value<String?>? name, Value<int>? externalId}) {
    return DemoTableBCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      externalId: externalId ?? this.externalId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (externalId.present) {
      map['external_id'] = Variable<int>(externalId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DemoTableBCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('externalId: $externalId')
          ..write(')'))
        .toString();
  }
}

abstract class _$DemoDatabase extends GeneratedDatabase {
  _$DemoDatabase(QueryExecutor e) : super(e);
  $DemoDatabaseManager get managers => $DemoDatabaseManager(this);
  late final $DemoTableATable demoTableA = $DemoTableATable(this);
  late final $DemoTableBTable demoTableB = $DemoTableBTable(this);
  late final TableADao tableADao = TableADao(this as DemoDatabase);
  late final TableBDao tableBDao = TableBDao(this as DemoDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [demoTableA, demoTableB];
}

typedef $$DemoTableATableCreateCompanionBuilder = DemoTableACompanion Function({
  Value<int> id,
  Value<String?> name,
  required int externalId,
});
typedef $$DemoTableATableUpdateCompanionBuilder = DemoTableACompanion Function({
  Value<int> id,
  Value<String?> name,
  Value<int> externalId,
});

class $$DemoTableATableFilterComposer
    extends FilterComposer<_$DemoDatabase, $DemoTableATable> {
  $$DemoTableATableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get externalId => $state.composableBuilder(
      column: $state.table.externalId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$DemoTableATableOrderingComposer
    extends OrderingComposer<_$DemoDatabase, $DemoTableATable> {
  $$DemoTableATableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get externalId => $state.composableBuilder(
      column: $state.table.externalId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$DemoTableATableTableManager extends RootTableManager<
    _$DemoDatabase,
    $DemoTableATable,
    DemoDriftEntityA,
    $$DemoTableATableFilterComposer,
    $$DemoTableATableOrderingComposer,
    $$DemoTableATableCreateCompanionBuilder,
    $$DemoTableATableUpdateCompanionBuilder,
    (
      DemoDriftEntityA,
      BaseReferences<_$DemoDatabase, $DemoTableATable, DemoDriftEntityA>
    ),
    DemoDriftEntityA,
    PrefetchHooks Function()> {
  $$DemoTableATableTableManager(_$DemoDatabase db, $DemoTableATable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$DemoTableATableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$DemoTableATableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<int> externalId = const Value.absent(),
          }) =>
              DemoTableACompanion(
            id: id,
            name: name,
            externalId: externalId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            required int externalId,
          }) =>
              DemoTableACompanion.insert(
            id: id,
            name: name,
            externalId: externalId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DemoTableATableProcessedTableManager = ProcessedTableManager<
    _$DemoDatabase,
    $DemoTableATable,
    DemoDriftEntityA,
    $$DemoTableATableFilterComposer,
    $$DemoTableATableOrderingComposer,
    $$DemoTableATableCreateCompanionBuilder,
    $$DemoTableATableUpdateCompanionBuilder,
    (
      DemoDriftEntityA,
      BaseReferences<_$DemoDatabase, $DemoTableATable, DemoDriftEntityA>
    ),
    DemoDriftEntityA,
    PrefetchHooks Function()>;
typedef $$DemoTableBTableCreateCompanionBuilder = DemoTableBCompanion Function({
  Value<int> id,
  Value<String?> name,
  required int externalId,
});
typedef $$DemoTableBTableUpdateCompanionBuilder = DemoTableBCompanion Function({
  Value<int> id,
  Value<String?> name,
  Value<int> externalId,
});

class $$DemoTableBTableFilterComposer
    extends FilterComposer<_$DemoDatabase, $DemoTableBTable> {
  $$DemoTableBTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get externalId => $state.composableBuilder(
      column: $state.table.externalId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$DemoTableBTableOrderingComposer
    extends OrderingComposer<_$DemoDatabase, $DemoTableBTable> {
  $$DemoTableBTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get externalId => $state.composableBuilder(
      column: $state.table.externalId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$DemoTableBTableTableManager extends RootTableManager<
    _$DemoDatabase,
    $DemoTableBTable,
    DemoDriftEntityB,
    $$DemoTableBTableFilterComposer,
    $$DemoTableBTableOrderingComposer,
    $$DemoTableBTableCreateCompanionBuilder,
    $$DemoTableBTableUpdateCompanionBuilder,
    (
      DemoDriftEntityB,
      BaseReferences<_$DemoDatabase, $DemoTableBTable, DemoDriftEntityB>
    ),
    DemoDriftEntityB,
    PrefetchHooks Function()> {
  $$DemoTableBTableTableManager(_$DemoDatabase db, $DemoTableBTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$DemoTableBTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$DemoTableBTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<int> externalId = const Value.absent(),
          }) =>
              DemoTableBCompanion(
            id: id,
            name: name,
            externalId: externalId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            required int externalId,
          }) =>
              DemoTableBCompanion.insert(
            id: id,
            name: name,
            externalId: externalId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DemoTableBTableProcessedTableManager = ProcessedTableManager<
    _$DemoDatabase,
    $DemoTableBTable,
    DemoDriftEntityB,
    $$DemoTableBTableFilterComposer,
    $$DemoTableBTableOrderingComposer,
    $$DemoTableBTableCreateCompanionBuilder,
    $$DemoTableBTableUpdateCompanionBuilder,
    (
      DemoDriftEntityB,
      BaseReferences<_$DemoDatabase, $DemoTableBTable, DemoDriftEntityB>
    ),
    DemoDriftEntityB,
    PrefetchHooks Function()>;

class $DemoDatabaseManager {
  final _$DemoDatabase _db;
  $DemoDatabaseManager(this._db);
  $$DemoTableATableTableManager get demoTableA =>
      $$DemoTableATableTableManager(_db, _db.demoTableA);
  $$DemoTableBTableTableManager get demoTableB =>
      $$DemoTableBTableTableManager(_db, _db.demoTableB);
}
