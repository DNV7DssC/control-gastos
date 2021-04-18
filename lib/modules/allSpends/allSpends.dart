import 'package:farmacap/main/homePage.dart';
import 'package:farmacap/models/models.dart';
import 'package:farmacap/providers/spends.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllSpends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gastos'),
      ),
      body: FutureBuilder(
        future: context.watch<Spends>().getAllSpends(),
        builder: (context, AsyncSnapshot<List<Spend>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data.length > 0) {
              return ListView(
                children: [
                  for (Spend spend in snapshot.data)
                    SpendTile(
                      spend: spend,
                      spends: snapshot.data,
                    )
                ],
              );
            } else {
              return Center(
                child: Container(
                  child: Text('No hay registros para mostrar.'),
                ),
              );
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
