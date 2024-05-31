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
          title: Text(
            "Búsqueda de Movimientos",
            style: TextStyle(color: Colors.white), // Text color is set to white
          ),
          backgroundColor: Color(0xFF1A1C60),
        ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  style:
                      TextStyle(color: Colors.white), // Set text color to white
                  decoration: InputDecoration(
                    hintText: "Buscar",
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    filled: true,
                    fillColor: Color.fromARGB(255, 95, 96, 133),
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}