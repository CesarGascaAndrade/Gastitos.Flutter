import 'dart:async';

import 'package:gastitos/Models/Movimiento.dart';
import 'package:gastitos/Repository/DataBaseRepository.dart';

class MovimientosRepository extends DataBaseRepository {
  @override
  String tableName = 'movimientos';

  Map<String, String> fields = {
    'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
    'concepto': 'VARCHAR(45) NOT NULL',
    'importe': 'FLOAT(10,2)',
    'fechaRegistro': 'DATETIME DEFAULT CURRENT_TIMESTAMP'
  };

  Future saveMovimiento(Movimiento movimiento) async {
    Map<String, Object> registro = {
      'id': movimiento.id,
      'concepto': movimiento.concepto,
      'importe': movimiento.importe,
      'fechaRegistro': movimiento.fechaRegistro
    };

    save(registro);
  }

  Future<List<Movimiento>> listIngresos({
    Map<String, Object> options = const {},
  }) async {
    /*
    List<Map<String, Object>> registros = await find(
        fields: [],
        where: Where([
          Condition(field: 'importe', value: '> 0'),
        ]),
        order: 'fechaRegistro desc');
    */

    List<Map<String, Object>> registros = await find(
      where: {'importe': '> 0'},
      order: 'fechaRegistro desc',
    );

    List<Movimiento> movimientos = [];

    registros.forEach((Map<String, dynamic> registro) {
      movimientos.add(Movimiento(
          id: registro['id'],
          concepto: registro['concepto'],
          importe: registro['importe'],
          fechaRegistro: registro['fechaRegistro']));
    });

    return movimientos;
  }

  Future<List<Movimiento>> listEgresos() async {
    List<Map<String, Object>> registros = await find(
      where: {'importe': '< 0'},
      order: 'fechaRegistro desc',
    );

    List<Movimiento> movimientos = [];

    registros.forEach((Map<String, dynamic> registro) {
      movimientos.add(Movimiento(
          id: registro['id'],
          concepto: registro['concepto'],
          importe: registro['importe'],
          fechaRegistro: registro['fechaRegistro']));
    });

    return movimientos;
  }

  Future<List<Map<String, dynamic>>> resumenIngresos() async {
    return find(fields: [
      "strftime('%Y-%m-%d',fechaRegistro) as fecha",
      'sum(importe) as importe',
    ], where: {
      'importe': '> 0'
    }, group: [
      'fecha',
      'importe'
    ]);
  }

  Future<List<Map<String, dynamic>>> resumenEgresos() async {
    return find(fields: [
      "strftime('%Y-%m-%d',fechaRegistro) as fecha",
      'sum(importe) as importe',
    ], where: {
      'importe': '< 0'
    }, group: [
      'fecha',
      'importe'
    ]);
  }
}
