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
          title: Text(
            "Perfil",
            style: TextStyle(color: Colors.white), // Text color is set to white
          ),
          backgroundColor: Color(0xFF1A1C60),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Text(
          "Esta página está en construcción.",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        SizedBox(height: 10),
        Icon(
          Icons.construction,
          color: Colors.white,
          size: 30.0,
        ),
          ],
        ),
      ),
    ))    ;
  }
}