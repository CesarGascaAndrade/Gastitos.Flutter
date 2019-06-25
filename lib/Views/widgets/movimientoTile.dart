import 'package:flutter/material.dart';
import 'package:gastitos/Models/Movimiento.dart';

Widget movimientoTile(Movimiento movimiento, Function deleteMovimiento) {
  var icon;
  var color;

  if (movimiento.importe < 0) {
    icon = Icons.arrow_back;
    color = Colors.red;
  } else {
    icon = Icons.arrow_forward;
    color = Colors.green;
  }

  return Dismissible(
    key: Key(movimiento.id.toString()),
    direction: DismissDirection.endToStart,
    background: Container(
      padding: EdgeInsets.only(right: 15.0),
      color: Colors.red,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            'Eliminar',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ],
      ),
    ),
    onDismissed: (DismissDirection direction) {
      deleteMovimiento();
    },
    child: Row(
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
      ],
    ),
  );
  /*
  return Dismissible(
    key: Key(movimiento.id.toString()),
    direction: DismissDirection.endToStart,
    background: Container(
      padding: EdgeInsets.only(right: 15.0),
      color: Colors.red,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            'Eliminar',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ],
      ),
    ),
    onDismissed: (DismissDirection direction) {
      deleteMovimiento();
    },
    child: ListTile(
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
            child: Text('${movimiento.concepto} \r\n (${movimiento.fechaRegistro.substring(0, 10)})'),
          ),
          Expanded(
            child: Container(),
          ),
          Text('\$${movimiento.importe.toString()}'),
        ],
      ),
    ),
  );
  */
}
