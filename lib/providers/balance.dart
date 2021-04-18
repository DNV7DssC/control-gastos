import 'package:flutter/material.dart';

import 'package:farmacap/repositories/sqliteDB.dart';

class Balance with ChangeNotifier {
  Future<String> getBalance() async {
    return await SqliteDB.dbProvider.getAvailableAmount();
  }

  Future<String> getAmount() async {
    return (await SqliteDB.dbProvider.getAmount()).value;
  }

  void updateAmount(double amount) async {
    await SqliteDB.dbProvider.updateAmount(amount);
    notifyListeners();
  }
}
