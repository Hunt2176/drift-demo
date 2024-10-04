import 'package:drift/drift.dart';


@DataClassName("DemoDriftEntityA", extending: EntityHasName, implementing: [ EntityHasExternalId ])
class DemoTableA extends TableBase with TableHasName, TableHasExternalId {
  @override
  String get tableName => 'table_a';
}

@DataClassName("DemoDriftEntityB", extending: EntityHasName, implementing: [ EntityHasExternalId ])
class DemoTableB extends TableBase with TableHasName, TableHasExternalId {
  @override
  String get tableName => 'table_b';
}


abstract class TableBase extends Table {
  IntColumn get id => integer().autoIncrement()();
}

mixin TableHasName on TableBase {
  TextColumn get name => text().nullable()();
}

mixin TableHasExternalId on TableBase {
  IntColumn get externalId => integer().unique()();
}


abstract class EntityBase extends DataClass {
  int? id;
}

abstract interface class EntityHasExternalId {
  int get externalId;
}

abstract class EntityHasName extends EntityBase {
  String? name;
}