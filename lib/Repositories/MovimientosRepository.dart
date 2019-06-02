import 'dart:async';

import 'package:gastitos/Models/Movimiento.dart';
import 'package:gastitos/Repositories/Repository.dart';

class MovimientosRepository extends Repository {
  @override
  String tableName = 'movimientos';

  @override
  List<Field> tableFields = [
    Field('id', 'INTEGER PRIMARY KEY AUTOINCREMENT'),
    Field('concepto', 'STRING'),
    Field('importe', 'DOUBLE'),
    Field('fechaRegistro', 'STRING')
  ];

  Future saveMovimiento(Movimiento movimiento) async {
    Map<String, dynamic> registro;

    registro['id'] = movimiento.id;
    registro['concepto'] = movimiento.concepto;
    registro['importe'] = movimiento.importe;
    registro['fechaRegistro'] = movimiento.fechaRegistro;

    save(registro);
  }

  Future<List<Movimiento>> listIngresos() async {
    List<Map<String, dynamic>> registros = await select(
      fields: [],
      where: Where([
        Condition(field: 'importe', value: '> 0'),
      ]),
    );

    List<Movimiento> movimientos = new List<Movimiento>();

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
    List<Map<String, dynamic>> registros = await select(
      fields: [],
      where: Where([
        Condition(field: 'importe', value: '< 0'),
      ]),
    );

    List<Movimiento> movimientos = new List<Movimiento>();

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
    return await select(
        fields: [
          'fechaRegistro',
          'sum(importe) as importe',
        ],
        where: Where([
          Condition(
            field: 'fechaRegistro',
            value:
                "between datetime('now','-30 days', 'localtime') and datetime('now')",
          )
        ]));
  }

  Future<List<Map<String, dynamic>>> resumenEgresos() async {
    return await select(
        fields: [
          'fechaRegistro',
          'sum(importe) as importe',
        ],
        where: Where([
          Condition(
            field: 'fechaRegistro',
            value:
                "between datetime('now','-30 days', 'localtime') and datetime('now')",
          )
        ]));
  }
}
