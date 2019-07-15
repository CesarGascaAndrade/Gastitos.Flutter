import 'package:flutter/material.dart';
import 'package:gastitos/ViewModels/MovimientosViewModel.dart';
import 'package:gastitos/Views/widgets/crossPlatformListTile.dart';
import 'package:gastitos/Views/widgets/graph.dart';
import 'package:scoped_model/scoped_model.dart';

class BalanceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScopedModelDescendant(
        builder: (
          BuildContext context,
          Widget child,
          MovimientosViewModel viewModel,
        ) {
          return ListView(
            children: <Widget>[
              crossPlatformListTile(
                title: Text('Ingresos'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('\$ '),
                    Text(viewModel.totalIngresos),
                  ],
                ),
              ),
              crossPlatformListTile(
                title: Text('Egresos'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('\$ '),
                    Text(viewModel.totalEgresos),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: SizedBox(
                  height: 200,
                  child: new DateTimeComboLinePointChart.withListData(viewModel.listEgresos)
                  //child: new DateTimeComboLinePointChart.withSampleData()
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
