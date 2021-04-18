part of '../main/homePage.dart';

Widget spendList(BuildContext context) {
  return Expanded(
    child: FutureBuilder(
      future: context.watch<Spends>().getTopSpend(),
      builder: (context, AsyncSnapshot<List<Spend>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data.length > 0) {
            return ListView(
              children: [
                for (Spend spend in snapshot.data)
                  SpendTile(
                    spend: spend,
                    spends: snapshot.data,
                  ),
              ],
            );
          } else {
            return Center(
              child: Container(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'No hay registros recientes',
                  style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic, color: Colors.red),
                ),
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ),
  );
}
