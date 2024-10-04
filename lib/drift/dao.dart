import 'package:drift/drift.dart';
import 'package:drift_demo/mock_http.dart';
import 'package:drift_demo/drift/table.dart';

import 'database.dart';

part 'dao.g.dart';

@DriftAccessor(tables: [
  DemoTableA
])
class TableADao extends BaseDao with _$TableADaoMixin {
  TableADao(super.attachedDatabase);

  Future<List<DemoDriftEntityA>> insertFromHttp(List<MockData> values) {
    final toInsert = values.map((val) {
      return DemoTableACompanion.insert(
        name: Value(val.name),
        externalId: val.id,
      );
    });

    return transaction(() async { // The inside of this transaction would never be reached as it would deadlock from this transaction call
      final res = <DemoDriftEntityA>[];
      for (final insert in toInsert) {
        final val = await into(demoTableA).insertReturning(insert,
          onConflict: DoUpdate((old) => insert, target: [demoTableA.externalId]),
        );

        res.add(val);
      }

      return res;
    });
  }
}

@DriftAccessor(tables: [
  DemoTableB
])
class TableBDao extends BaseDao with _$TableBDaoMixin {
  TableBDao(super.attachedDatabase);

  Future<List<DemoDriftEntityB>> insertFromHttp(List<MockData> values) {
    final toInsert = values.map((val) {
      return DemoTableBCompanion.insert(
        name: Value(val.name),
        externalId: val.id,
      );
    });

    return transaction(() async {
      final res = <DemoDriftEntityB>[];
      for (final insert in toInsert) {
        final val = await into(demoTableB).insertReturning(insert,
            onConflict: DoUpdate((old) => insert, target: [demoTableB.externalId]),
        );

        res.add(val);
      }

      return res;
    });
  }
}


abstract class BaseDao extends DatabaseAccessor<DemoDatabase> {
  BaseDao(super.attachedDatabase);
}