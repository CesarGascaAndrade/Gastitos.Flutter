import 'package:flutter/material.dart';
import 'package:gastitos/ViewModels/MovimientosViewModel.dart';
import 'package:gastitos/Views/widgets/movimientoTile.dart';
import 'package:scoped_model/scoped_model.dart';

class IngresosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScopedModelDescendant(
        builder: (
          BuildContext context,
          Widget child,
          MovimientosViewModel viewModel,
        ) {
          return viewModel.ingresos == null
              ? CircularProgressIndicator()
              : viewModel.ingresos.length == 0
                  ? Text('No hay ingresos')
                  : ListView.builder(
                      itemCount: viewModel.ingresos.length,
                      itemBuilder: (
                        BuildContext context,
                        int index,
                      ) {
                        
                        return movimientoTile(viewModel.ingresos[index], () {
                          viewModel.deleteMovimiento(viewModel.ingresos[index]);
                        }, context);
                      },
                    );
        },
      ),
    );
  }
}
