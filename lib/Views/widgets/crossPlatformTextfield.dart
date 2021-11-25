import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget crossPlatformTextfield({
  String? label,
  TextEditingController? controller,
  TextInputType keyboardType = TextInputType.text,
  InputDecoration? decoration,
  required Function(String) validator,
  bool enabled = true,
}) {
  if (Platform.isIOS) {
    return CupertinoTextField(
      controller: controller,
      keyboardType: keyboardType,
      //decoration: decoration,
      placeholder: label,
      enabled: enabled,
    );
  } else {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label),
      //validator: validator,
      enabled: enabled,
    );
  }
}
