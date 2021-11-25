import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget crossPlatformApp({
  String title = 'Titulo',
  String initialRoute = '/',
  Map<String, WidgetBuilder> routes = const {},
}) {
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

crossThemeData({MaterialColor primaryColor: Colors.blueGrey}) {
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
