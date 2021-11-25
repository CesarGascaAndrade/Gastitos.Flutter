import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget crossPlatformButton({
  required Widget child,
  required Function onPressed,
}) {
  if (Platform.isIOS) {
    return CupertinoButton(
      child: child,
      onPressed: () => {onPressed()},
    );
  } else {
    return RaisedButton(
      child: child,
      onPressed: () => {onPressed()},
    );
  }
}
