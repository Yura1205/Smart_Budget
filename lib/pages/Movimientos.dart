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
                        _buildMovimientoItem("Movimiento 1",
                            "Descripción del movimiento 1", "\$100.00"),
                        _buildMovimientoItem("Movimiento 2",
                            "Descripción del movimiento 2", "\$200.00"),
                        _buildMovimientoItem("Movimiento 3",
                            "Descripción del movimiento 3", "\$300.00"),
                        _buildMovimientoItem("Movimiento 4",
                            "Descripción del movimiento 4", "\$400.00"),
                        _buildMovimientoItem("Movimiento 5",
                            "Descripción del movimiento 5", "\$500.00"),
                        _buildMovimientoItem("Movimiento 6",
                            "Descripción del movimiento 6", "\$600.00"),
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
                      padding:
                          EdgeInsets.all(20), // Padding around the button icon
                      backgroundColor:
                          Colors.white, // Assign color to the ElevatedButton
                    ),
                    onPressed: () {
                      openOptionDialog(); // Abre el diálogo de opciones
                    },
                    child: Icon(
                      Icons.add,
                      color: Color(
                          0xFFF2003D), // Set the color of the Icon to white
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
                        backgroundColor:
                            Color(0xFF27D0C6), // Blue background color
                        shape: CircleBorder(), // Make the button circular
                        minimumSize: Size(36, 36), // Set the size of the button
                      ),
                      child: Icon(Icons.edit,
                          color: Colors.white,
                          size: 18), // Adjust the size of the icon
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        openDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF2003D),
                        shape: CircleBorder(),
                        minimumSize: Size(36, 36),
                      ),
                      child: Icon(Icons.delete, color: Colors.white, size: 18),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Método para abrir el diálogo con opciones
  Future openOptionDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Seleccionar Tipo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Gasto"),
                onTap: () {
                  Navigator.of(context).pop();
                  openCreateDialog("Gasto");
                },
              ),
              ListTile(
                title: Text("Ingreso"),
                onTap: () {
                  Navigator.of(context).pop();
                  openCreateDialog("Ingreso");
                },
              ),
            ],
          ),
        ),
      );

  // Método para abrir el diálogo de crear registro
  Future openCreateDialog(String type) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Crear $type"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Ingrese el nombre del movimiento",
                ),
              ),
              SizedBox(height: 8), // Espacio entre los TextFields
              TextField(
                maxLines: 3, // Ajusta el número de líneas según sea necesario
                decoration: InputDecoration(
                  hintText: "Ingrese la descripción del movimiento",
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Ingrese el valor del movimiento",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                // Lógica para crear el registro
                Navigator.of(context).pop();
              },
              child: Text("Crear"),
            ),
          ],
        ),
      );

  // Método original de eliminar para referencia
  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Crear Registro"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Ingrese el nombre del movimiento",
                ),
              ),
              SizedBox(height: 8), // Espacio entre los TextFields
              TextField(
                maxLines: 3, // Ajusta el número de líneas según sea necesario
                decoration: InputDecoration(
                  hintText: "Ingrese la descripción del movimiento",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                // Lógica para crear el registro
                Navigator.of(context).pop();
              },
              child: Text("Crear"),
            ),
          ],
        ),
      );
}
