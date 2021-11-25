import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget crossPlatformSwitch({
  bool value = true,
  required Function(bool) onChanged,
}) {
  if (Platform.isIOS) {
    return CupertinoSwitch(
      value: value,
      onChanged: onChanged,
    );
  } else {
    return Switch(
      value: value,
      onChanged: onChanged,
    );
  }
}
