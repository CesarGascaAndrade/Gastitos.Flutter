import 'package:flutter/material.dart';

void confirmDialog(BuildContext context, Function onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Precaución'),
        content: Text('Esta acción no se puede deshacer ¿Deseas confirmar?'),
        actions: <Widget>[
          FlatButton(
            child: Text('Elinimar'),
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}