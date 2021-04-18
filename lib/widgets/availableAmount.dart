part of '../main/homePage.dart';

Widget availableAmount(BuildContext context) {
  return FutureBuilder(
    future: context.watch<Balance>().getBalance(),
    builder: (context, AsyncSnapshot<String> snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasData) {
          return Container(
            padding: EdgeInsets.only(bottom: 20.0, top: 10.0),
            child: Text(
              'RD\$ ${snapshot.data}',
              style: TextStyle(fontSize: 50.0, color: Colors.blue[900]),
            ),
          );
        } else {
          return Container(
            padding: EdgeInsets.only(bottom: 20.0, top: 10.0),
            child: Text(
              'RD\$ 0.00',
              style: TextStyle(fontSize: 50.0, color: Colors.green),
            ),
          );
        }
      } else {
        return CircularProgressIndicator();
      }
    },
  );
}
