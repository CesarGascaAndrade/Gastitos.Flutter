class Movimiento {
  int id;
  String concepto;
  double importe;
  String fechaRegistro;

  Movimiento(
      {this.id = 0,
      this.concepto = '',
      this.importe = 0,
      this.fechaRegistro = ''}) {
    if (fechaRegistro == '') {
      fechaRegistro = new DateTime.now().toIso8601String();
    }
  }
}
