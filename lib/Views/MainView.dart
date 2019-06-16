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
  int _currentIndex = 1;

  final List<Widget> tab = [
    new EgresosView(),
    new BalanceView(),
    new IngresosView(),
  ];

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
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.account_balance_wallet),
        title: Text("Gastitos"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/nuevoMovimiento', arguments: ToNewMovementViewArgs(_movementType));
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

  Widget showTab(int index) {
    return tab[index];
  }
}
