import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_demo/drift/dao.dart';
import 'package:drift_demo/drift/table.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    DemoTableA, DemoTableB
  ],
  daos: [
    TableADao, TableBDao
  ]
)
class DemoDatabase extends _$DemoDatabase {
  DemoDatabase(): super( NativeDatabase.memory(logStatements: true) );

  @override
  int get schemaVersion => 1;
}