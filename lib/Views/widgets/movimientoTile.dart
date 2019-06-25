import 'package:flutter/material.dart';
import 'package:gastitos/Models/Movimiento.dart';

import 'package:gastitos/Views/widgets/confirmDialog.dart';

Widget movimientoTile(Movimiento movimiento, Function deleteMovimiento, BuildContext context) {
  var icon;
  var color;

  if (movimiento.importe < 0) {
    icon = Icons.arrow_back;
    color = Colors.red;
  } else {
    icon = Icons.arrow_forward;
    color = Colors.green;
  }

  return ListTile(
    key: Key(movimiento.id.toString()),
    leading: Icon(
      icon,
      color: color,
    ),
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          flex: 10,
          child: Text(
              '${movimiento.concepto} \r\n (${movimiento.fechaRegistro.substring(0, 10)})'),
        ),
        Expanded(
          child: Container(),
        ),
        Text('\$${movimiento.importe.toStringAsFixed(2)}'),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            confirmDialog(context, deleteMovimiento);
          },
        )
      ],
    ),
  );
}


