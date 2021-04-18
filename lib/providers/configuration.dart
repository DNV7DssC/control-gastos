import 'package:flutter/material.dart';

import 'package:farmacap/repositories/sqliteDB.dart';

class Configuration with ChangeNotifier {
  Future<List<Config>> getAllConfigurations() async {
    return SqliteDB.dbProvider.getAllConfigurations();
  }
}
