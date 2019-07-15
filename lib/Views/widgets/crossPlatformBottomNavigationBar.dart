//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:gastitos/mPlatform.dart';

Widget crossPlatformNavigationBar({List<BottomNavigationBarItem> items, Function onTap, int currentIndex}) {
  if (Platform.isIOS) {
    return CupertinoTabBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: items,
    );
  } else {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: items,
    );
  }
}
