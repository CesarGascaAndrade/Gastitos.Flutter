import 'package:flutter/material.dart';

void confirmDialog(Widget title, Widget body, Function onConfirm, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title,
        content: body,
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