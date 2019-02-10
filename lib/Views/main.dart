import 'package:flutter/material.dart';
import 'package:gastitos/Views/balance.dart';
import 'package:gastitos/Views/egresos.dart';
import 'package:gastitos/Views/ingresos.dart';

class MainView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainViewState();
  }

}

class MainViewState extends State<MainView>{
  int _currentIndex = 1;

  final List<Widget> tab = [
    EgresosView(),
    BalanceView(),
    IngresosView(),
  ];

  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gastitos"),
      ),
      body: tab[_currentIndex],
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
