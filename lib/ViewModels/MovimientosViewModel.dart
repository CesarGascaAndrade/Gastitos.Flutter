import 'dart:async';

import 'package:gastitos/Models/Movimiento.dart';
import 'package:gastitos/Services/MovimientosService.dart';
import 'package:scoped_model/scoped_model.dart';

class MovimientosViewModel extends Model {
  late MovimientosService service;

  MovimientosViewModel(MovimientosService service) {
    this.service = service;

    loadMovimientos();
  }

  double _totalIngresos = 0;
  double _totalEgresos = 0;

  late List<Movimiento> ingresos;
  late List<Movimiento> egresos;
  late List<Map<String, dynamic>> listIngresos;
  late List<Map<String, dynamic>> listEgresos;

  get totalIngresos {
    return _totalIngresos.toStringAsFixed(2);
  }

  get totalEgresos {
    return _totalEgresos.toStringAsFixed(2);
  }

  Future loadMovimientos() async {
    ingresos = await service.getListIngresos();
    egresos = await service.getListEgresos();
    listIngresos = await service.getResumenIngresos();
    listEgresos = await service.getResumenEgresos();

    _totalIngresos = 0;
    ingresos.forEach((Movimiento movimiento) {
      _totalIngresos += movimiento.importe;
    });

    _totalEgresos = 0;
    egresos.forEach((Movimiento movimiento) {
      _totalEgresos += movimiento.importe;
    });

    notifyListeners();
  }

  Future<void> saveMovimiento(Movimiento movimiento) async {
    await service.save(movimiento);
    await loadMovimientos();

    notifyListeners();
  }

  Future<void> deleteMovimiento(Movimiento movimiento) async {
    await service.delete(movimiento);
    await loadMovimientos();
    notifyListeners();
  }
}
