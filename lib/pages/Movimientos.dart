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

  Future<void> _addMovimiento(String type, String descripcion, double cantidad, String categoria) async {
    if (_database == null) return;

    String table = type.toLowerCase();

    await _database!.insert(
      table,
      {
        'descripcion': descripcion,
        'cantidad': cantidad,
        'fecha': DateTime.now().toIso8601String(), // Opcional, ya que se maneja por la DB
        'categoria': categoria,
        'balanceId': null,  // Si tienes un balanceId disponible, puedes pasarlo aquí
      },
    );

    await _loadMovimientos();
  }

  Widget _buildMovimientoItem(String tipo, String descripcion, double cantidad) {
    return ListTile(
      title: Text(tipo, style: TextStyle(color: Colors.white)),
      subtitle: Text(descripcion, style: TextStyle(color: Colors.white70)),
      trailing: Text(
        '\$${cantidad.toStringAsFixed(2)}',
        style: TextStyle(
          color: tipo == 'Gasto' ? Color(0xFFF2003D) : Color(0xFF27D0C6),
        ),
      ),
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
                                movimiento['cantidad'],
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
        builder: (context) {
          final _descripcionController = TextEditingController();
          final _cantidadController = TextEditingController();
          final _categoriaController = TextEditingController();

          return AlertDialog(
            title: Text("Crear $type"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _descripcionController,
                  decoration: InputDecoration(
                    hintText: "Ingrese la descripción del movimiento",
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _cantidadController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Ingrese el valor del movimiento",
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _categoriaController,
                  decoration: InputDecoration(
                    hintText: "Ingrese la categoría del movimiento",
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
                  final descripcion = _descripcionController.text;
                  final cantidad = double.tryParse(_cantidadController.text) ?? 0.0;
                  final categoria = _categoriaController.text;

                  if (descripcion.isNotEmpty && cantidad > 0 && categoria.isNotEmpty) {
                    _addMovimiento(type, descripcion, cantidad, categoria);
                  }

                  Navigator.of(context).pop();
                },
                child: Text("Crear"),
              ),
            ],
          );
        },
      );
}
