import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget crossPlatformNavigationBar({
  required List<BottomNavigationBarItem> items,
  required Function(int) onTap,
  required int currentIndex,
}) {
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
