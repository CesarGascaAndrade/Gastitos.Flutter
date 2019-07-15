//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:gastitos/mPlatform.dart';

Widget crossPlatformSwitch({bool value, Function onChanged}) {
  if (Platform.isIOS) {
    return CupertinoSwitch(
      value: value,
      onChanged: onChanged,
    );
  }
  else {
    return Switch(
      value: value,
      onChanged: onChanged,
    );
  }
}