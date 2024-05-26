import 'package:smart_budget_app/dataBase_local/crud.dart';

class Balance extends Crud {
  Balance() : super('balance');

  Future<List<Map<String, dynamic>>> getBalances() async {
    return await query('SELECT * FROM balance');
  }

  Future<Map<String, dynamic>> getBalanceDetails(int id) async {
    final balance = (await query('SELECT * FROM balance WHERE id = ?', arguments: [id])).first;
    final gastos = await query('SELECT * FROM gasto WHERE balanceId = ?', arguments: [id]);
    final ingresos = await query('SELECT * FROM ingreso WHERE balanceId = ?', arguments: [id]);

    return {
      'balance': balance,
      'gastos': gastos,
      'ingresos': ingresos,
    };
  }

  Future<int> createBalance(Map<String, dynamic> data) async {
    return await create(data);
  }

  Future<int> updateBalance(Map<String, dynamic> data) async {
    return await update(data);
  }

  Future<int> deleteBalance(int id) async {
    return await delete(id);
  }
}
