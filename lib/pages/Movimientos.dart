// ignore_for_file: prefer_const_constructors

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
                    child: ListView.builder(
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
                      openCreateDialog();
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

  Future openCreateDialog() => showDialog(
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

  Future openEditDialog(String title, String subtitle, String value) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Editar Registro"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Ingrese el nuevo nombre del movimiento",
                ),
                controller: TextEditingController(text: title),
              ),
              SizedBox(height: 8),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Ingrese la nueva descripción del movimiento",
                ),
                controller: TextEditingController(text: subtitle),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: "Ingrese el nuevo valor del movimiento",
                ),
                controller: TextEditingController(text: value),
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
                // Lógica para editar el registro
                Navigator.of(context).pop();
              },
              child: Text("Guardar"),
            ),
          ],
        ),
      );

  Future openDeleteDialog(String title) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Eliminar Registro"),
          content: Text("¿Está seguro que desea eliminar el movimiento \"$title\"?"),
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
}
