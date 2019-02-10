import 'package:flutter/material.dart';

class BalanceView extends StatelessWidget {
  Widget _buildMovimiento(String concepto, double monto) {
    var icon;
    var color;

    if (monto < 0) {
      icon = Icons.arrow_back;
      color = Colors.red;
    } else {
      icon = Icons.arrow_forward;
      color = Colors.green;
    }

    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Row(
        children: <Widget>[
          Text(concepto),
          Expanded(
            child: Container(),
          ),
          Text('\$${monto.toString()}'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildMovimiento('Gastito 1', 15),
        _buildMovimiento('Gastito 1', -15),
        _buildMovimiento('Gastito 1', -45),
        _buildMovimiento('Gastito 1', 100),
        _buildMovimiento('Gastito 1', 15),
        _buildMovimiento('Gastito 1', 15),
        _buildMovimiento('Gastito 1', 15),
      ],
    );
  }
}
