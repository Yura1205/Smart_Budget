import 'package:smart_budget_app/dataBase_local/crud.dart';

class Gasto extends Crud {
  Gasto() : super('gasto');

  Future<List<Map<String, dynamic>>> getGastos() async {
    return await query('SELECT * FROM gasto');
  }

  Future<int> createGasto(Map<String, dynamic> data) async {
    return await create(data);
  }

  Future<int> updateGasto(Map<String, dynamic> data) async {
    return await update(data);
  }

  Future<int> deleteGasto(int id) async {
    return await delete(id);
  }
}
