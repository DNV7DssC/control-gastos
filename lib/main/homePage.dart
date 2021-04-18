import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import 'package:farmacap/providers/providers.dart';
import 'package:farmacap/repositories/sqliteDB.dart';
import 'package:farmacap/modules/addSpend/addSpend.dart';

part '../widgets/spendList.dart';
part '../widgets/spendTile.dart';
part '../widgets/availableAmount.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FarmACAP'),
        actions: [
          IconButton(
            icon: Platform.isIOS ? Icon(CupertinoIcons.gear_alt_fill) : Icon(Icons.settings),
            onPressed: () async {
              Navigator.pushNamed(context, '/config',
                  arguments: await context.read<Configuration>().getAllConfigurations());
            },
          ),
        ],
      ),
      body: _body(),
      floatingActionButton: fab(),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 10.0, top: 15.0),
          child: Text(
            'Saldo disponible',
            style: TextStyle(fontSize: 25.0),
          ),
        ),
        availableAmount(context),
        Container(
          padding: EdgeInsets.only(bottom: 20.0),
          child: Text(
            'Últimos gastos realizados',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        spendList(context),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              color: Colors.yellow[700],
              child: Text('Ver todos los gastos'),
              onPressed: () {
                Navigator.pushNamed(context, '/allSpends');
              },
            ),
          ),
        )
      ],
    );
  }

  Widget fab() {
    return FloatingActionButton(
      backgroundColor: Colors.blue[900],
      child: Icon(
        Icons.add,
        size: 40,
      ),
      onPressed: () => _showDialog(context),
    );
  }

  void _showDialog(BuildContext context) async {
    List<DropdownMenuItem> _items = List<DropdownMenuItem>();
    List<Pharmacy> _pharmas = await context.read<Store>().getPharmacies();
    _pharmas.forEach((pharmacy) {
      _items.add(DropdownMenuItem(
        child: Text(pharmacy.name),
        value: pharmacy.id,
      ));
    });
    await showDialog(context: context, builder: (_) => AddSpend(items: _items));
    setState(() {});
  }
}
