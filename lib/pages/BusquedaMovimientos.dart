import "package:flutter/material.dart";

class Busqueda extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Busqueda();
  }
}

class _Busqueda extends State<Busqueda> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFF1A1C60),
      appBar: AppBar(
        title: Text("Búsqueda de Movimientos"),
      ),
      body: Center(
        child: Text("Búsqueda de Movimientos"),
      ),
    ));
  }
}
