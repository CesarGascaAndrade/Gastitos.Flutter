//import 'dart:io';
import 'package:gastitos/mPlatform.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget crossPlatformApp(
    {String title,
    String initialRoute,
    Map<String, WidgetBuilder> routes}) {
  if (Platform.isIOS) {
    return CupertinoApp(
      title: title,
      theme: crossThemeData(),
      initialRoute: initialRoute,
      routes: routes,
    );
  } else {
    return MaterialApp(
      title: title,
      theme: crossThemeData(),  
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}

crossThemeData() {
  if (Platform.isIOS) {
    return CupertinoThemeData(
      
    );
  } else {
    return ThemeData(
      primarySwatch: Colors.blueGrey,
    );
  }
}