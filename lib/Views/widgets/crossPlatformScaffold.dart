//import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../mPlatform.dart';

import 'package:flutter/widgets.dart';


Widget crossPlatformScaffold({
  Widget appBar,
  Widget body,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      navigationBar: appBar,
      child: body,
    );
  } else {
    return Scaffold(
      appBar: appBar,
    );
  }
}