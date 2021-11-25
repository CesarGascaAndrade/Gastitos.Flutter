import 'package:flutter/material.dart';

import 'package:gastitos/ViewModels/MovimientosViewModel.dart';
import 'package:gastitos/Views/widgets/movimientoTile.dart';
import 'package:scoped_model/scoped_model.dart';

class EgresosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScopedModelDescendant(
        builder: (
          context,
          child,
          MovimientosViewModel viewModel,
        ) {
          return viewModel.egresos == null
              ? CircularProgressIndicator()
              : viewModel.egresos.length == 0
                  ? Text('No hay egresos')
                  : ListView.builder(
                      itemCount: viewModel.egresos.length,
                      itemBuilder: (
                        BuildContext context,
                        int index,
                      ) {
                        return movimientoTile(viewModel.egresos[index], () {
                          viewModel.deleteMovimiento(viewModel.egresos[index]);
                        }, context);
                      },
                    );
        },
      ),
    );
  }
}
