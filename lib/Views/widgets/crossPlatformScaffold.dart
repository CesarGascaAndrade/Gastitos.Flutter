import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

crossPlatformScaffold({
  required appBar,
  required Widget body,
  Widget? bottomNavigationBar,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      navigationBar: appBar,
      child: Column(
        children: <Widget>[
          Expanded(
            child: body,
          ),
          bottomNavigationBar != null ? bottomNavigationBar : Container()
        ],
      ),
    );
  } else {
    return Scaffold(
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
