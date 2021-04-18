import 'package:flutter/material.dart';

import 'package:farmacap/repositories/sqliteDB.dart';

class Spends with ChangeNotifier {
  Future<List<Spend>> getAllSpends() async {
    return SqliteDB.dbProvider.getAllSpend();
  }

  void addSpend(Spend spend) async {
    await SqliteDB.dbProvider.addSpend(spend: spend);
    notifyListeners();
  }

  void delSpend(int spendId) async {
    if (await SqliteDB.dbProvider.deleteSpend(spendId: spendId)) {
      notifyListeners();
    }
  }

  Future<List<Spend>> getTopSpend() async {
    int quantity = await _getQuantity();
    return await SqliteDB.dbProvider.getTopSpend(quantity);
  }

  Future<int> _getQuantity() async {
    Config config = await SqliteDB.dbProvider.getQuantity();
    return int.parse(config.value);
  }

  void updateQuantity(int quantity) async {
    await SqliteDB.dbProvider.updateQuantity(quantity);
    notifyListeners();
  }
}
