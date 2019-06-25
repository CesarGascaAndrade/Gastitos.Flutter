//import 'dart:io';
import 'package:gastitos/Views/widgets/crossPlatformAppBar.dart';
import 'package:gastitos/Views/widgets/crossPlatformIconButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gastitos/Views/widgets/crossPlatformScaffold.dart';
import 'package:gastitos/mPlatform.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gastitos/Models/ToNewMovementViewArgs.dart';
import 'package:gastitos/Views/balanceView.dart';
import 'package:gastitos/Views/egresosView.dart';
import 'package:gastitos/Views/ingresosView.dart';

class MainView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainViewState();
  }
}

class _MainViewState extends State<MainView> {
  int _movementType = 1;
  int _currentIndex = 0;

  final List<Widget> tab = [
    new EgresosView(),
    new Container(
      child: Center(
        child: Text('EgresosView'),
      ),
    ),
    //new BalanceView(),
    new Container(
      child: Center(
        child: Text('BalanceView'),
      ),
    ),
    //new IngresosView(),
    new Container(
      child: Center(
        child: Text('IngresosView'),
      ),
    ),
  ];

  Widget _showTab(int index) {
    return tab[index];
  }

  void onTabTapped(int index) {
    setState(() {
      if (index == 0) {
        _movementType = -1;
      } else {
        _movementType = 1;
      }

      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body = _showTab(_currentIndex);

    Widget scaffold = crossPlatformScaffold(
      appBar: crossPlatformAppBar(
        leading: Icon(FontAwesomeIcons.wallet),
        title: Text('Gastitos'),
        action: crossPlatformIconButton(
          icon: Icon(FontAwesomeIcons.plus),
          onPressed: () {
            Navigator.pushNamed(context, '/nuevoMovimiento',
                arguments: ToNewMovementViewArgs(_movementType));
          },
        ),
      ),
      body: body,
    );

    return scaffold;
  }
}





/*
Widget x_crossPlatformScaffold(
  BuildContext context, {
  String title,
  Widget body,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('middle'),
      ),
      child: Center(
        child: Text('Cupertino page'),
      ),
    );
  } else {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.account_balance_wallet),
        title: Text("Gastitos"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/nuevoMovimiento',
                  arguments: ToNewMovementViewArgs(_movementType));
            },
          )
        ],
      ),
      body: showTab(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: new Icon(Icons.money_off),
            title: new Text('Egresos'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.account_balance),
            title: new Text('Balance'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            title: Text('Ingresos'),
          )
        ],
      ),
    );
  }
}
*/
