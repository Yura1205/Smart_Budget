import 'package:smart_budget_app/dataBase_local/crud.dart';

class Ingreso extends Crud {
  Ingreso() : super('ingreso');

  Future<List<Map<String, dynamic>>> getIngresos() async {
    return await query('SELECT * FROM ingreso');
  }

  Future<int> createIngreso(Map<String, dynamic> data) async {
    return await create(data);
  }

  Future<int> updateIngreso(Map<String, dynamic> data) async {
    return await update(data);
  }

  Future<int> deleteIngreso(int id) async {
    return await delete(id);
  }
}
