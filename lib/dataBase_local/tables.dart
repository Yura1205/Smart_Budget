// tables.dart
const String gastoTable = "gasto";
const String ingresoTable = "ingreso";
const String balanceTable = "balance";

List get tables => [
  _createTable(
    gastoTable,
    "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
    "cantidad REAL,"
    "fecha DATE,"
    "categoria TEXT,"
    "descripcion TEXT,"
    "balanceId INTEGER,"
    "FOREIGN KEY(balanceId) REFERENCES $balanceTable(id)"
  ),
  _createTable(
    ingresoTable,
    "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
    "cantidad REAL,"
    "fecha DATE,"
    "categoria TEXT,"
    "descripcion TEXT,"
    "balanceId INTEGER,"
    "FOREIGN KEY(balanceId) REFERENCES $balanceTable(id)"
  ),
  _createTable(
    balanceTable,
    "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
    "nombre TEXT,"
    "fechaInicio DATE,"
    "limiteGastos REAL,"
    "porcentajeDeError REAL"
  )
];

_createTable(String table, String columns) {
  return "CREATE TABLE IF NOT EXISTS $table ($columns)";
}
