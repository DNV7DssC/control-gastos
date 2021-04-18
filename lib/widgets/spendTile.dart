part of '../main/homePage.dart';

class SpendTile extends StatelessWidget {
  final Spend spend;
  final List<Spend> spends;

  SpendTile({this.spend, this.spends});

  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat('#,##0.00', 'en-US');
    return FutureBuilder(
      future: SqliteDB.dbProvider.getPharmacyById(spend.pharmacyId),
      builder: (context, AsyncSnapshot<Pharmacy> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              child: ListTile(
                title: Text(snapshot.data.name),
                subtitle: Text(DateFormat.yMd().format(DateTime.parse(spend.createdAt))),
                trailing: Text(
                  'RD\$ ${numberFormat.format(spend.amount)}',
                  style: TextStyle(fontSize: 15.0, color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              background: Container(
                padding: EdgeInsets.only(right: 20.0),
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                ),
              ),
              confirmDismiss: (_) async {
                bool result = false;
                await showDialog(
                  context: context,
                  builder: (_) {
                    if (Platform.isIOS) {
                      return CupertinoAlertDialog(
                        content: Text('Esta acción eliminará definitivamente el registro'),
                        actions: [
                          CupertinoDialogAction(
                            child: Text('Cancelar'),
                            onPressed: () {
                              context.navigation.pop();
                            },
                          ),
                          CupertinoDialogAction(
                            child: Text('Eliminar'),
                            isDestructiveAction: true,
                            isDefaultAction: true,
                            onPressed: () {
                              context.read<Spends>().delSpend(spend.id);
                              context.navigation.pop();
                            },
                          ),
                        ],
                      );
                    } else {
                      return AlertDialog(
                        title: Text('Atención'),
                        content: Text('Esta acción eliminará definitivamente el registro'),
                        actions: [
                          FlatButton(
                            textColor: Colors.blue[900],
                            onPressed: () {
                              context.navigation.pop();
                            },
                            child: Text('Cancelar'),
                          ),
                          FlatButton(
                            textColor: Colors.red,
                            onPressed: () {
                              context.read<Spends>().delSpend(spend.id);
                              context.navigation.pop();
                            },
                            child: Text('Eliminar'),
                          ),
                        ],
                      );
                    }
                  },
                );
                return result;
              },
              onDismissed: (_) {
                spends.remove(spend);
              },
            );
          } else {
            return Text('N/A');
          }
        } else {
          return Container();
        }
      },
    );
  }
}
