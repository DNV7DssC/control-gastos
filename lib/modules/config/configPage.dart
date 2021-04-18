import 'package:farmacap/providers/providers.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:farmacap/models/models.dart';
import 'package:farmacap/providers/balance.dart';
import 'package:farmacap/extensions/ContextExtension.dart';
import 'package:string_validator/string_validator.dart';

class ConfigPage extends StatelessWidget {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final NumberFormat numberFormat = NumberFormat('###0', 'en-US');

  @override
  Widget build(BuildContext context) {
    List<Config> config = context.modalRoute.settings.arguments;

    Config _amountConfig = config.where((config) {
      return config.name == 'amount';
    }).first;
    Config _quantityConfig = config.where((config) {
      return config.name == 'quantity';
    }).first;

    _amountController.text = numberFormat.format(double.parse(_amountConfig.value));
    _quantityController.text = numberFormat.format(double.parse(_quantityConfig.value));

    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text(
              //   'Monto Límite',
              //   style: context.textTheme.headline5,
              // ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Límite'),
                  Expanded(
                    flex: 4,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      onChanged: (String amount) {
                        if (isNumeric(amount) && amount.compareTo('0') != 0) {
                          context.read<Balance>().updateAmount(double.parse(amount));
                        }
                      },
                    ),
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Últimos movimientos a mostrar'),
                  Expanded(flex: 5, child: SizedBox()),
                  Expanded(
                    child: TextField(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      onChanged: (String quantity) {
                        if (isInt(quantity) && quantity.compareTo('0') != 0) {
                          context.read<Spends>().updateQuantity(int.parse(quantity));
                        }
                      },
                    ),
                  )
                ],
              ),
              Divider(),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tema oscuro',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Switch(
                    onChanged: null,
                    value: false,
                  )
                ],
              ),
              TextButton(
                child: Text('Sobre esta aplicación'),
                onPressed: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'FarmACAP',
                    applicationVersion: '1.0.0',
                    applicationLegalese: 'Paul Pérez © 2021',
                    // children: [
                    //   Text('Hola Mundo'),
                    // ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
