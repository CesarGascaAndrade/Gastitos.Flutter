//import 'dart:io';
import 'package:gastitos/mPlatform.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget crossPlatformApp(
    {String title, String initialRoute, Map<String, WidgetBuilder> routes}) {
  if (Platform.isIOS) {
    return CupertinoApp(
      title: title,
      theme: crossThemeData(primaryColor: Colors.blueGrey),
      initialRoute: initialRoute,
      routes: routes,
    );
  } else {
    return MaterialApp(
      title: title,
      theme: crossThemeData(primaryColor: Colors.blueGrey),
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}

crossThemeData({Color primaryColor: Colors.blueGrey}) {
  if (Platform.isIOS) {
    return CupertinoThemeData(
      primaryColor: primaryColor,
    );
  } else {
    return ThemeData(
      primarySwatch: primaryColor,
    );
  }
}
