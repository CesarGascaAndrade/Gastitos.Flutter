import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

crossPlatformAppBar({
  required Widget leading,
  required Widget title,
  required Widget action,
}) {
  print(Platform.isIOS);
  if (Platform.isIOS) {
    return CupertinoNavigationBar(
      leading: leading,
      middle: title,
      trailing: action,
    );
  } else {
    return AppBar(
      leading: leading,
      title: title,
      actions: <Widget>[action],
    );
  }
}
