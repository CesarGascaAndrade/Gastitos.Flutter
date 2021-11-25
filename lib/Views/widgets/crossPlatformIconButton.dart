import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget crossPlatformIconButton({
  required Icon icon,
  required Function onPressed,
}) {
  if (Platform.isIOS) {
    return CupertinoButton(
      padding: EdgeInsets.all(0),
      child: icon,
      onPressed: () => {onPressed()},
    );
  } else {
    return IconButton(
      icon: icon,
      onPressed: () => {onPressed()},
    );
  }
}
