class Movimiento {
  int id;
  String concepto;
  double importe;
  String fechaRegistro;

  Movimiento({this.id, this.concepto, this.importe, this.fechaRegistro}) {
    if (fechaRegistro == null) {
      fechaRegistro = new DateTime.now().toIso8601String();
    }
  }
}
