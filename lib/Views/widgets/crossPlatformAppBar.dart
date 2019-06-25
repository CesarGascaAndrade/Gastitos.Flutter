//import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../mPlatform.dart';

import 'package:flutter/widgets.dart';

Widget crossPlatformAppBar({
  Widget leading,
  Widget title,
  Widget action,
}) {
  print(action);
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
