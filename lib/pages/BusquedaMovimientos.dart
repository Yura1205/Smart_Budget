import 'package:flutter/material.dart';
import 'package:smart_budget_app/models/gasto.dart';
import 'package:smart_budget_app/models/ingreso.dart';

class Busqueda extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Busqueda();
  }
}

class _Busqueda extends State<Busqueda> {
  TextEditingController _controller = TextEditingController();
  List<String> _historial = [];
  List<Map<String, dynamic>> _resultados = [];
  final int _limiteHistorial = 5;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _controller.text.trim();
    if (query.isEmpty) {
      setState(() {
        _resultados.clear();
      });
      return;
    }
    _buscar(query);
  }

  Future<void> _buscar(String query) async {
    final gastoCrud = Gasto();
    final ingresoCrud = Ingreso();

    List<Map<String, dynamic>> gastoResultados = await gastoCrud.query(
        'SELECT * FROM gasto WHERE cantidad LIKE ? OR categoria LIKE ? OR descripcion LIKE ?',
        arguments: ['%$query%', '%$query%', '%$query%']);
    List<Map<String, dynamic>> ingresoResultados = await ingresoCrud.query(
        'SELECT * FROM ingreso WHERE cantidad LIKE ? OR categoria LIKE ? OR descripcion LIKE ?',
        arguments: ['%$query%', '%$query%', '%$query%']);

    setState(() {
      _resultados = [...gastoResultados, ...ingresoResultados];
      _actualizarHistorial(query);
    });
  }

  void _actualizarHistorial(String query) {
    if (_historial.contains(query)) {
      _historial.remove(query);
    }
    _historial.insert(0, query);
    if (_historial.length > _limiteHistorial) {
      _historial = _historial.sublist(0, _limiteHistorial);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF1A1C60),
          appBar: AppBar(
            title: Text(
              "Búsqueda de Movimientos",
              style: TextStyle(color: Colors.white),
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
                      controller: _controller,
                      style: TextStyle(color: Colors.white),
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
                Expanded(
                  child: _controller.text.isEmpty
                      ? _buildHistorial()
                      : _buildResultados(),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildHistorial() {
    return _historial.isEmpty
        ? Center(
            child: Text(
              'No hay búsquedas recientes',
              style: TextStyle(color: Colors.white),
            ),
          )
        : ListView.builder(
            itemCount: _historial.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  _historial[index],
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  _controller.text = _historial[index];
                },
              );
            },
          );
  }

  Widget _buildResultados() {
    return _resultados.isEmpty
        ? Center(
            child: Text(
              'No se encontraron resultados',
              style: TextStyle(color: Colors.white),
            ),
          )
        : ListView.builder(
            itemCount: _resultados.length,
            itemBuilder: (context, index) {
              final item = _resultados[index];
              return ListTile(
                title: Text(
                  item['descripcion'] ?? '',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'Cantidad: ${item['cantidad'] ?? ''}',
                  style: TextStyle(color: Colors.white70),
                ),
              );
            },
          );
  }
}
