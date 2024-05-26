import 'package:flutter/material.dart';

class Movimientos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MovimientosState();
  }
}

class _MovimientosState extends State<Movimientos> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF1A1C60),
        appBar: AppBar(
          title: Text(
            "Movimientos",
            style: TextStyle(color: Colors.white), // Text color is set to white
          ),
          backgroundColor: Color(0xFF1A1C60),
        ),
        body: Center(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 15),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildMovimientoItem("Movimiento 1", "Descripción del movimiento 1", "\$100.00"),
                        _buildMovimientoItem("Movimiento 2", "Descripción del movimiento 2", "\$200.00"),
                        _buildMovimientoItem("Movimiento 3", "Descripción del movimiento 3", "\$300.00"),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), // Make the button circular
                      padding: EdgeInsets.all(20), // Padding around the button icon
                      backgroundColor: Color(0xFFF2003D), // Assign color to the ElevatedButton
                    ),
                    onPressed: () {
                      // Add your logic here
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white, // Set the color of the Icon to white
                      size: 30, // Adjust the size of the icon
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovimientoItem(String title, String subtitle, String value) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Expanded(
        child: ListTile(
          title: Text(title, style: TextStyle(color: Colors.white)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subtitle, style: TextStyle(color: Colors.white70)),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(value, style: TextStyle(color: Colors.white)),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Add your edit logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:const Color(0xFF27D0C6), // Blue background color
                          shape: CircleBorder(), // Make the button circular
                        ),
                        child: Icon(Icons.edit, color: Colors.white, size: 18), // Adjust the size of the icon
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Add your delete logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF2003D), // Red background color
                          shape: CircleBorder(), // Make the button circular
                        ),
                        child: Icon(Icons.delete, color: Colors.white, size: 18), // Adjust the size of the icon
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
