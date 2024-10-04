import 'package:drift_demo/mock_http.dart';
import 'package:drift_demo/drift/database.dart';

void main() async {
  final db = DemoDatabase();
  final http = const MockHttp();

  final runner = TransactionRunner((toExecute) async {
    // Removing this transaction and running `toExecute` directly would prevent the deadlock
    return await db.transaction(() {
      return toExecute(db);
    }, requireNew: true);
  });

  await runner.execute((db) async {
    final valuesA = await http.get();
    final valuesB = await http.get();

    await db.tableADao.insertFromHttp(valuesA); // This line is where the deadlock would occur, check dao.dart for where it deadlocks directly
    await db.tableBDao.insertFromHttp(valuesB);
  });
}

class TransactionRunner {
  TransactionRunner(this.execute);
  final Future<void> Function(Future<void> Function(DemoDatabase database) toExecute) execute;

  final toExecute = <Future<void> Function(DemoDatabase database)>[];
}