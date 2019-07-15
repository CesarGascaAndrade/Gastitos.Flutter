import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gastitos/Models/Movimiento.dart';

import 'package:gastitos/Views/widgets/confirmDialog.dart';
import 'package:gastitos/Views/widgets/crossPlatformIconButton.dart';

Widget movimientoTile(
    Movimiento movimiento, Function deleteMovimiento, BuildContext context) {
  var icon;
  var color;

  if (movimiento.importe < 0) {
    icon = Icons.arrow_back;
    color = Colors.red;
  } else {
    icon = Icons.arrow_forward;
    color = Colors.green;
  }

  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Icon(
          icon,
          color: color,
        ),
      ),
      Expanded(
        flex: 5,
        child: Text(
            '${movimiento.concepto} \r\n (${movimiento.fechaRegistro.substring(0, 10)})'),
      ),
      Expanded(
        child: Container(),
      ),
      Expanded(
        flex: 2,
        child: Text('\$${movimiento.importe.toStringAsFixed(2)}'),
      ),
      crossPlatformIconButton(
        icon: Icon(FontAwesomeIcons.trash),
        onPressed: () {
          confirmDialog(
            Text('Precaución'),
            Text('Esta acción no se puede deshacer ¿Deseas confirmar?'),
            deleteMovimiento,
            context,
          );
        },
      ),
    ],
  );
  /*
  return Dismissible(
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
  */
}
