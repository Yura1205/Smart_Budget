// crud.dart
import 'package:smart_budget_app/dataBase_local/db.dart';
import 'package:sqflite/sqflite.dart';


abstract class Crud {
  String table;

  Crud(this.table);

  Future<Database> get database async {
    return await Db().open();
  }

  Future<List<Map<String, dynamic>>> query(String sql, {List<dynamic> arguments = const []}) async {
    return (await database).rawQuery(sql, arguments);
  }

  Future<int> update(Map<String, dynamic> data) async {
    return (await database).update(table, data, where: "id=?", whereArgs: [data["id"]]);
  }

  Future<int> create(Map<String, dynamic> data) async {
    return (await database).insert(table, data);
  }

  Future<int> delete(int id) async {
    return (await database).delete(table, where: "id = ?", whereArgs: [id]);
  }
}
