import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smart_budget_app/components/balanceChart.dart';
import 'package:smart_budget_app/models/balance.dart';

class BalancePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BalancePage();
  }
}

class _BalancePage extends State<BalancePage> {
  final Balance balanceModel = Balance();
  late Future<Map<String, List<Map<String, dynamic>>>> balanceData;

  @override
  void initState() {
    super.initState();
    balanceData = balanceModel.getGastosIngresosPorBalance(052024); // Cambia el ID según tu lógica
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF1A1C60),
        appBar: AppBar(
          title: Text(
            "Balance",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF1A1C60),
        ),
        body: FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
          future: balanceData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData) {
              return Center(child: Text("No data available"));
            } else {
              final gastos = snapshot.data!['gastos']!
                  .map((e) => FlSpot(e['semana'].toDouble(), e['cantidad'].toDouble()))
                  .toList();
              final ingresos = snapshot.data!['ingresos']!
                  .map((e) => FlSpot(e['semana'].toDouble(), e['cantidad'].toDouble()))
                  .toList();

              return BalanceChart(gastos: gastos, ingresos: ingresos);
            }
          },
        ),
      ),
    );
  }
}
