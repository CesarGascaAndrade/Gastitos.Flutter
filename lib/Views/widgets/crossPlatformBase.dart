import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget crossPlatformWidget({
  bool value = true,
  required Function onChanged,
}) {
  if (Platform.isIOS) {
    return Container();
  } else {
    return Container();
  }
}
