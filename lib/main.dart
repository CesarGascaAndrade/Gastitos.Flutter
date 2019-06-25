import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:gastitos/Repositories/MovimientosRepository.dart';
import 'package:gastitos/Services/MovimientosService.dart';
import 'package:gastitos/ViewModels/MovimientosViewModel.dart';
import 'package:gastitos/Views/MovimientoFormView.dart';
import 'package:gastitos/Views/balanceView.dart';
import 'package:gastitos/Views/egresosView.dart';
import 'package:gastitos/Views/ingresosView.dart';
import 'package:gastitos/Views/mainView.dart';
import 'package:scoped_model/scoped_model.dart';

import 'Views/widgets/crossPlatformApp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MovimientosViewModel viewModel = new MovimientosViewModel(
      new MovimientosService(
        new MovimientosRepository(),
      ),
    );
    return ScopedModel(
      model: viewModel,
      child: crossPlatformApp(
        title: 'Gastitos',
        initialRoute: '/',
        routes: {
          '/': (context) => MainView(),
          '/ingresos': (context) => IngresosView(),
          '/egresos': (context) => EgresosView(),
          '/balance': (context) => BalanceView(),
          '/nuevoMovimiento': (context) => MovimientoFormView()
        },
      ),
    );
  }
}

