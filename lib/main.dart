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
      child: MaterialApp(
        title: 'Gastitos',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MainView(),
          '/test': (context) => Scaffold(
            appBar: AppBar(
              title: Text('Test mode'),
            ),
            body: new BalanceView(),
          ),
          '/ingresos': (context) => IngresosView(),
          '/egresos': (context) => EgresosView(),
          '/balance': (context) => BalanceView(),
          '/nuevoMovimiento' : (context) => MovimientoFormView()
        },
      ),
    );
  }
}
