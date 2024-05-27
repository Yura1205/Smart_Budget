import 'package:flutter/material.dart';
import 'package:smart_budget_app/pages/BusquedaMovimientos.dart';
import 'package:smart_budget_app/pages/Movimientos.dart';
import 'package:smart_budget_app/pages/Balance.dart';
import 'package:smart_budget_app/pages/MenuPrincipal.dart';
import 'package:smart_budget_app/pages/Perfil.dart';

class MyNavigator extends StatefulWidget {
  const MyNavigator({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyNavigator();
  }
}

class _MyNavigator extends State<MyNavigator> {
  int _currentIndex = 2;
  final List<Widget> _children = [
    Busqueda(),
    Movimientos(),
    MyHomePage(),
    Balance(),
    Perfil()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF0F1046), // Cambia este color para el fondo
        selectedItemColor: const Color(0xFF27D0C6), // Cambia este color para el ítem seleccionado
        unselectedItemColor: Colors.white, // Cambia este color para los ítems no seleccionados
        items: const [
          
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_rtl),
            label: "Movimientos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Menu",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: "Balance",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
          )
        ],
        type: BottomNavigationBarType.fixed, // Asegura que todos los ítems se muestren correctamente
        iconSize: 30.0
      ),
    );
  }
}