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
      order: 'fechaRegistro desc'
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
      order: 'fechaRegistro desc'
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
        "strftime('%Y-%m-%d',fechaRegistro) as fecha",
        'sum(importe) as importe',
      ],
      where: Where([
        Condition(
          field: 'importe',
          value:
              "> 0",
        )
      ]),
      groupFields: ' fecha, importe',
      
    );
  }

  Future<List<Map<String, dynamic>>> resumenEgresos() async {
    List<Map<String, dynamic>> resumen = List<Map<String, dynamic>>();
    var movimientos = await select(
      fields: [
        "strftime('%Y-%m-%d',fechaRegistro) as fecha",
        'sum(importe) * -1 as importe',
      ],
      where: Where([
        Condition(
          field: 'importe',
          value:
              "< 0",
        )
      ]),
      groupFields: "fecha, importe",
    );

    movimientos.forEach((m) {
      List<Map<String, dynamic>> registros = resumen.where((e) => e['fecha'] == m['fecha']).toList();

      if(registros.length > 0) {
        for(int i = 0; i < resumen.length; i++) {

          if(resumen[i]['fecha'] == m['fecha']) {
            String fecha = m['fecha'];
            double importe = resumen[i]['importe'] + m['importe'];
            resumen.removeAt(i);
            resumen.add({
              'fecha': fecha,
              'importe': importe
            });
          }
        }
      }
      else {
        resumen.add(m);
      }
    });

    return resumen;
  }
}
