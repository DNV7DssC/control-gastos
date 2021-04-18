import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'main/homePage.dart';
import 'package:farmacap/providers/providers.dart';
import 'package:farmacap/modules/config/configPage.dart';
import 'package:farmacap/modules/allSpends/allSpends.dart';

part 'config/themes/themes.dart';
part 'config/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Store()),
      ChangeNotifierProvider(create: (_) => Spends()),
      ChangeNotifierProvider(create: (_) => Balance()),
      ChangeNotifierProvider(create: (_) => Configuration()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FarmACAP',
      theme: theme(),
      initialRoute: '/',
      routes: routes,
    );
  }
}
