import 'package:flutter/material.dart';

import 'package:farmacap/repositories/sqliteDB.dart';

class Store with ChangeNotifier {
  Future<List<Pharmacy>> getPharmacies() async {
    return SqliteDB.dbProvider.getAllPharmacies();
  }

  Future<Pharmacy> getPharmacyById(int id) async {
    return SqliteDB.dbProvider.getPharmacyById(id);
  }
}
