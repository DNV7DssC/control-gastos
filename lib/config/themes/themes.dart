part of '../../main.dart';

ThemeData theme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue[900],
    accentColor: Colors.cyan[600],
    fontFamily: 'Ubuntu',
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue[800],
    ),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline4: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 26.0),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Ubuntu'),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
