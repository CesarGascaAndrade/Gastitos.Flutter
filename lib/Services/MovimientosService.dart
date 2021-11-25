import 'dart:async';

import 'package:gastitos/Models/Movimiento.dart';
import 'package:gastitos/Repository/MovimientosRepository.dart';

class MovimientosService {
  MovimientosRepository repository;

  MovimientosService(this.repository);

  Future<List<Movimiento>> getListIngresos() async {
    return await this.repository.listIngresos();
  }

  Future<List<Movimiento>> getListEgresos() async {
    return await this.repository.listEgresos();
  }

  Future<List<Map<String, dynamic>>> getResumenIngresos() async {
    return await this.repository.resumenIngresos();
  }

  Future<List<Map<String, dynamic>>> getResumenEgresos() async {
    return await this.repository.resumenEgresos();
  }

  Future<void> save(Movimiento movimiento) async {
    Map<String, Object> registro = {
      'id': movimiento.id,
      'concepto': movimiento.concepto,
      'importe': movimiento.importe,
      'fechaRegistro': movimiento.fechaRegistro
    };

    /*
    registro['id'] = movimiento.id;
    registro['concepto'] = movimiento.concepto;
    registro['importe'] = movimiento.importe;
    registro['fechaRegistro'] = movimiento.fechaRegistro;

    */

    await this.repository.save(registro);
  }

  Future<void> delete(Movimiento movimiento) async {
    await this.repository.delete(movimiento.id);
  }
}
