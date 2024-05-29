import 'package:smart_budget_app/dataBase_local/tables.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Db {
  String name = "SmartBudget";
  int version = 1;
  Database? _database;

  Future<Database> open() async {
    if (_database != null) {
      return _database!;
    }

    String path = join(await getDatabasesPath(), name);
    _database = await openDatabase(
      path,
      version: version,
      onConfigure: onConfigure,
      onCreate: onCreate,
    );
    return _database!;
  }

  Future<void> onCreate(Database db, int version) async {
    for (var script in tables) {
      await db.execute(script);
    }
  }

  Future<void> onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  Future<void> deleteRecordsWithNullBalanceId() async {
    final db = await open();
    await db.transaction((txn) async {
      await txn.delete('gasto', where: 'balanceId IS NULL');
      await txn.delete('ingreso', where: 'balanceId IS NULL');
    });
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
