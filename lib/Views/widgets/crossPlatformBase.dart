//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:gastitos/mPlatform.dart';

Widget crossPlatformWidget({bool value, Function onChanged}) {
  if (Platform.isIOS) {
    return Container();
  }
  else {
    return Container();
  }
}