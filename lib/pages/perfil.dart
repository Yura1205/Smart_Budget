import "package:flutter/material.dart";

class Perfil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Perfil();
  }
}

class _Perfil extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFF1A1C60),
      appBar: AppBar(
        title: Text("Perfil"),
      ),
      body: Center(
        child: Text("Perfil"),
      ),
    ));
  }
}
