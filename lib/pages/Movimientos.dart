import 'package:flutter/material.dart';
import 'package:smart_budget_app/dataBase_local/db.dart';
import 'package:sqflite/sqflite.dart';

class Movimientos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MovimientosState();
  }
}

class _MovimientosState extends State<Movimientos> {
  List<Map<String, dynamic>> movimientos = [];
  Database? _database;

  @override
  void initState() {
    super.initState();
    _initDb();
  }

  @override
  void dispose() {
    _database?.close();
    super.dispose();
  }

  Future<void> _initDb() async {
    _database = await Db().open();
    await _loadMovimientos();
  }

  Future<void> _loadMovimientos() async {
    if (_database == null) return;

    final gastos = await _database!.rawQuery('''
      SELECT "Gasto" as tipo, cantidad, fecha, categoria, descripcion 
      FROM gasto 
      WHERE fecha >= date('now', '-1 month') 
      ORDER BY fecha DESC
    ''');

    final ingresos = await _database!.rawQuery('''
      SELECT "Ingreso" as tipo, cantidad, fecha, categoria, descripcion 
      FROM ingreso 
      WHERE fecha >= date('now', '-1 month') 
      ORDER BY fecha DESC
    ''');

    setState(() {
      movimientos = [...gastos, ...ingresos];
      movimientos.sort((a, b) => b['fecha'].compareTo(a['fecha']));
    });
  }

  Widget _buildMovimientoItem(String tipo, String descripcion, String cantidad) {
    return ListTile(
      title: Text(tipo, style: TextStyle(color: Colors.white)),
      subtitle: Text(descripcion, style: TextStyle(color: Colors.white70)),
      trailing: Text(cantidad, style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildEmptyMessage() {
    return Center(
      child: Text(
        "No hay movimientos para mostrar",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF1A1C60),
        appBar: AppBar(
          title: Text(
            "Movimientos",
            style: TextStyle(color: Colors.white),
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
                    child: movimientos.isEmpty
                        ? _buildEmptyMessage()
                        : ListView.builder(
                            itemCount: movimientos.length,
                            itemBuilder: (context, index) {
                              final movimiento = movimientos[index];
                              return _buildMovimientoItem(
                                movimiento['tipo'],
                                movimiento['descripcion'],
                                '\$${movimiento['cantidad'].toStringAsFixed(2)}',
                              );
                            },
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
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      openOptionDialog(); // Abre el diálogo de opciones
                    },
                    child: Icon(
                      Icons.add,
                      color: Color(0xFFF2003D),
                      size: 30,
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
              SizedBox(height: 8),
              TextField(
                maxLines: 3,
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
          title: Text("Eliminar Registro"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("¿Estás seguro de que quieres eliminar este registro?"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                // Lógica para eliminar el registro
                Navigator.of(context).pop();
              },
              child: Text("Eliminar"),
            ),
          ],
        ),
      );

  Widget _buildMovimientoItemWithActions(String title, String subtitle, String value) {
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
                        backgroundColor: Color(0xFF27D0C6), // Blue background color
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
}
