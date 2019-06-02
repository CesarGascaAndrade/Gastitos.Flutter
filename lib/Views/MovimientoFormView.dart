import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gastitos/Models/Movimiento.dart';
import 'package:gastitos/ViewModels/MovimientosViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class MovimientoFormView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MovimientoFormState();
  }
}

class _MovimientoFormState extends State {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fechaInput = new TextEditingController();
  TextEditingController conceptoInput = new TextEditingController();
  TextEditingController importeInput = new TextEditingController();

  DateTime _fecha = new DateTime.now();

  @override
  initState() {
    super.initState();
    fechaInput.text = _fecha.toIso8601String().substring(0, 10);
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _fecha,
      firstDate: new DateTime((_fecha.year - 1)),
      lastDate: new DateTime.now(),
    );

    if (picked != null && picked != _fecha) {
      setState(() {
        _fecha = picked;
        fechaInput.text = picked.toIso8601String().substring(0, 10);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo movimiento'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: TextFormField(
                      controller: fechaInput,
                      enabled: false,
                      //keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(labelText: 'Fecha'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return '¿Cuándo fué?';
                        }
                      },
                    ),
                  ),
                  TextFormField(
                    controller: conceptoInput,
                    decoration: InputDecoration(labelText: 'Concepto'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '¿En qué gastaste?';
                      }
                    },
                  ),
                  TextFormField(
                    controller: importeInput,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Importe'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '¿Cuánto fué?';
                      }
                    },
                  ),
                  Center(
                    child: ScopedModelDescendant(
                      builder: (
                        BuildContext context,
                        Widget child,
                        MovimientosViewModel viewModel,
                      ) {
                        return RaisedButton(
                          child: Text('Guardar'),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              // If the form is valid, display a snackbar. In the real world, you'd
                              // often want to call a server or save the information in a database
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Guardando'),
                                ),
                              );

                              viewModel.saveMovimiento(new Movimiento(
                                concepto: conceptoInput.text,
                                importe: double.parse(importeInput.text),
                                fechaRegistro: _fecha.toIso8601String(),
                              )).then((value) {
                                Navigator.pop(context);
                              });
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
