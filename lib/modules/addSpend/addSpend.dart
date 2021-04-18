import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:kartal/kartal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:farmacap/providers/providers.dart';
import 'package:farmacap/repositories/sqliteDB.dart';

class AddSpend extends StatefulWidget {
  final items;

  AddSpend({this.items});

  @override
  _AddSpendState createState() => _AddSpendState();
}

class _AddSpendState extends State<AddSpend> {
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  var _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 100.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Agregar gasto',
              style: context.textTheme.headline4,
            ),
            SizedBox(height: 15.0),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(helperText: 'Descripción'),
              keyboardType: TextInputType.text,
              maxLength: 40,
            ),
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(helperText: 'Monto'),
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            DropdownButtonFormField(
              items: widget.items,
              value: _selectedValue,
              decoration: InputDecoration(helperText: 'Farmacia'),
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
              },
              elevation: 11,
              iconSize: 20.0,
              isDense: true,
              isExpanded: true,
              autofocus: false,
              onTap: () {},
              onSaved: (_) {},
            ),
            SizedBox(height: 70.0),
            Row(
              children: [
                if (Platform.isIOS)
                  CupertinoButton(
                    color: Colors.red[900],
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Cancelar'),
                    onPressed: () => context.navigation.pop(),
                  )
                else
                  FlatButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Cancelar'),
                    onPressed: () => context.navigation.pop(),
                  ),
                Expanded(child: Container()),
                if (Platform.isIOS)
                  CupertinoButton(
                    color: Colors.blue[900],
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Guardar'),
                    onPressed: () {
                      Spend spend = Spend(
                        description: _descriptionController.text,
                        pharmacyId: 1,
                        amount: num.parse(_amountController.text),
                        createdAt: DateTime.now().toIso8601String(),
                        userId: 1,
                      );

                      context.read<Spends>().addSpend(spend);
                      context.navigation.pop();
                    },
                  )
                else
                  FlatButton(
                    color: Colors.blue[900],
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Guardar'),
                    onPressed: () {
                      Spend spend = Spend(
                        description: _descriptionController.text,
                        pharmacyId: 1,
                        amount: num.parse(_amountController.text),
                        createdAt: DateTime.now().toIso8601String(),
                        userId: 1,
                      );

                      context.read<Spends>().addSpend(spend);
                      context.navigation.pop();
                    },
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
