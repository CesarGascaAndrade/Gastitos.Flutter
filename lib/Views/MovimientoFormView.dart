import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gastitos/Models/Movimiento.dart';

import 'package:gastitos/Models/ToNewMovementViewArgs.dart';
import 'package:gastitos/ViewModels/MovimientosViewModel.dart';

import 'package:gastitos/Views/widgets/crossPlatformAppBar.dart';
import 'package:gastitos/Views/widgets/crossPlatformScaffold.dart';
import 'package:gastitos/Views/widgets/crossPlatformSwitch.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:gastitos/Views/widgets/crossPlatformTextfield.dart';

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

    //initMovementTypeState(context);
  }

  Future<Null> _selectDate(BuildContext context) async {
    var picked;
    if (Platform.isIOS) {
      showBottomSheet(
        backgroundColor: Color.fromARGB(128, 0, 0, 0),
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.only(top: 280.0),
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: _fecha,
                      maximumDate: DateTime.now(),
                      onDateTimeChanged: (DateTime value) {
                        setState(() {
                          _fecha = value;
                          fechaInput.text =
                              value.toIso8601String().substring(0, 10);
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: CupertinoButton(
                          color: Colors.white,
                          child: Text(
                            'Aceptar',
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      picked = await showDatePicker(
        context: context,
        initialDate: _fecha,
        firstDate: new DateTime((_fecha.year - 1)),
        lastDate: new DateTime.now(),
      );
    }

    if (picked != null && picked != _fecha) {
      setState(() {
        _fecha = picked;
        fechaInput.text = picked.toIso8601String().substring(0, 10);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ToNewMovementViewArgs args =
        ModalRoute.of(context)!.settings.arguments as ToNewMovementViewArgs;

    String _movementLabel = (args.movementType > 0) ? 'ingreso' : 'egreso';

    return crossPlatformScaffold(
      appBar: crossPlatformAppBar(
        leading: Icon(FontAwesomeIcons.wallet),
        title: Text('Nuevo $_movementLabel'),
        action: crossPlatformSwitch(
          value: args.movementType > 0,
          onChanged: (bool value) {
            setState(() {
              args.movementType = args.movementType * -1;
            });
          },
          //activeColor: Colors.green,
          //inactiveThumbColor: Colors.red,
        ),
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
                      print('I was Tapped!!!');
                    },
                    behavior: HitTestBehavior.opaque,
                    child: crossPlatformTextfield(
                      //CupertinoDatePicker(onDateTimeChanged: (DateTime value) {},
                      controller: fechaInput,
                      enabled: false,
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value.isEmpty) {
                          return '¿Cuándo fué?';
                        }

                        return true;
                      },
                    ),
                  ),
                  crossPlatformTextfield(
                    label: 'Concepto',
                    controller: conceptoInput,
                    validator: (value) {
                      if (value.isEmpty) {
                        return '¿En qué gastaste?';
                      }

                      return true;
                    },
                  ),
                  crossPlatformTextfield(
                    label: 'Importe',
                    controller: importeInput,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return '¿Cuánto fué?';
                      }

                      return true;
                    },
                  ),
                  Center(
                    child: ScopedModelDescendant(
                      builder: (
                        context,
                        child,
                        MovimientosViewModel viewModel,
                      ) {
                        return RaisedButton(
                          child: Text('Guardar'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world, you'd
                              // often want to call a server or save the information in a database
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Guardando'),
                                ),
                              );

                              viewModel
                                  .saveMovimiento(new Movimiento(
                                concepto: conceptoInput.text,
                                importe: double.parse(importeInput.text) *
                                    args.movementType,
                                fechaRegistro: _fecha.toIso8601String(),
                              ))
                                  .then((value) {
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
