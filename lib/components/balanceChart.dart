import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BalanceChart extends StatelessWidget {
  final List<FlSpot> gastos;
  final List<FlSpot> ingresos;

  BalanceChart({required this.gastos, required this.ingresos});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(enabled: true),
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
            getTextStyles: (BuildContext context, double value) => TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            showTitles: true,
            getTitles: (value) {
              switch (value.toInt()) {
                case 1:
                  return 'Semana 1';
                case 2:
                  return 'Semana 2';
                case 3:
                  return 'Semana 3';
                case 4:
                  return 'Semana 4';
              }
              return '';
            },
            interval: 1,
            reservedSize: 22,
            margin: 8,
          ),
          leftTitles: SideTitles(
            getTextStyles: (BuildContext context, double value) => TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            showTitles: true,
            getTitles: (value) {
              switch (value.toInt()) {
                case 400000:
                  return '400K';
                case 800000:
                  return '800K';
                case 1200000:
                  return '1.2M';
                case 1600000:
                  return '1.6M';
                case 2000000:
                  return '2M';
                case 2400000:
                  return '2.4M';
                case 2800000:
                  return '2.8M';
                case 3200000:
                  return '3.2M';
              }
              return '';
            },
            interval: 400000,
            reservedSize: 40,
            margin: 8,
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Color.fromARGB(255, 254, 254, 254), width: 1),
        ),
        
        minX: 1,
        maxX: 4,
        minY: 0,
        maxY: 3200000,
        
        
        lineBarsData: [
          LineChartBarData(
            spots: gastos,
            isCurved: true,
            colors: [Colors.red],
            barWidth: 4,
            belowBarData: BarAreaData(show: false),
          ),
          LineChartBarData(
            spots: ingresos,
            isCurved: true,
            colors: [Colors.green],
            barWidth: 4,
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
