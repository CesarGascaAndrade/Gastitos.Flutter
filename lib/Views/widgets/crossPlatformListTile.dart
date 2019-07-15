import 'package:flutter/material.dart';
import 'package:gastitos/mPlatform.dart';

Widget crossPlatformListTile({
  Widget leading,
  Widget title,
  Widget subtitle,
  Widget trailing,
}) {
  if (Platform.isIOS) {
    List<Widget> elements = [];

    if (leading != null) elements.add(leading);

    if (title != null) elements.add(title);

    if (subtitle != null) elements.add(subtitle);

    elements.add(
      Expanded(
        child: Container(),
      ),
    );

    if (trailing != null) elements.add(trailing);

    return Container(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: elements,
      ),
    );
  } else {
    return ListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
    );
  }
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
