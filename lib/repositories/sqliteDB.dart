import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import 'package:farmacap/models/models.dart';

export 'package:farmacap/models/models.dart';

class SqliteDB {
  static Database _database;
  static final dbProvider = SqliteDB._();

  SqliteDB._();

  Future<Database> initDB() async {
    return await openDatabase('facap.db', version: 1, onCreate: _onCreate, onOpen: (db) {});
  }

  _onCreate(Database db, int version) async {
    // Creating tables
    await db.execute("CREATE TABLE User (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, created_at TEXT)");
    await db.execute(
        "CREATE TABLE Pharmacy (id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE, name TEXT UNIQUE, location TEXT)");
    await db
        .execute("CREATE TABLE Config (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id INTEGER, name TEXT, value TEXT)");
    await db.execute(
        "CREATE TABLE Spend (id INTEGER PRIMARY KEY AUTOINCREMENT, amount REAL, description TEXT, created_at TEXT, user_id INTEGER, pharmacy_id INTEGER)");

    //Adding data
    await db.insert("user", {'id': 1, 'name': 'Nuevo usuario', 'created_At': DateTime.now().toIso8601String()});
    await db.insert("config", {'id': 1, 'user_id': 1, 'name': 'amount', 'value': '7000'});
    await db.insert("config", {'id': 2, 'user_id': 1, 'name': 'quantity', 'value': '5'});
    await db.insert("Pharmacy", {'id': 1, 'name': 'Carol', 'location': ''});
  }

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<int> addSpend({Spend spend}) async {
    final _db = await database;
    return _db.insert('Spend', spend.toMap());
  }

  Future<int> updateSpend(Spend spend) async {
    final _db = await database;
    return _db.update('Spend', spend.toMap());
  }

  Future<bool> deleteSpend({int spendId}) async {
    final _db = await database;
    int res = await _db.delete('Spend', where: 'id = ?', whereArgs: [spendId]);
    return res == 0 ? false : true;
  }

  Future<List<Spend>> getAllSpend() async {
    final _db = await database;
    List<Map<String, dynamic>> results = await _db.query('Spend');
    return results.map((map) => Spend.fromMap(map)).toList();
  }

  Future<double> getAmountOfAllSpends() async {
    final _db = await database;
    double _amount = 0;
    List<Map<String, dynamic>> results = await _db.query('Spend', columns: ['amount']);
    for (var amount in results) {
      _amount += amount.values.first;
    }
    return _amount;
  }

  Future<String> getAvailableAmount() async {
    Config _totalAmount = await getAmount();
    double _spendSmount = await getAmountOfAllSpends();
    double available = double.parse(_totalAmount.value) - _spendSmount;
    if (available < 0)
      return '0.00';
    else {
      NumberFormat numberFormat = NumberFormat('#,##0.00', 'en-US');
      return numberFormat.format(available);
    }
  }

  Future<List<Spend>> getTopSpend(int quantity) async {
    final _db = await database;
    List<Map<String, dynamic>> results = await _db.query('Spend', orderBy: 'id DESC', limit: quantity);
    return results.map((map) => Spend.fromMap(map)).toList();
  }

  Future<Pharmacy> getPharmacyById(int id) async {
    final _db = await database;

    List<Map<String, dynamic>> results = await _db.query(
      'Pharmacy',
      limit: 1,
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.map((map) => Pharmacy.fromMap(map)).first;
  }

  Future<List<Pharmacy>> getAllPharmacies() async {
    final _db = await database;
    List<Map<String, dynamic>> results = await _db.query('Pharmacy');
    return results.map((map) => Pharmacy.fromMap(map)).toList();
  }

  Future<List<Config>> getAllConfigurations() async {
    final _db = await database;
    List<Map<String, dynamic>> results = await _db.query('Config');
    return results.map((map) => Config.fromMap(map)).toList();
  }

  Future<int> dropDB({Spend spend}) async {
    final _db = await database;
    return _db.delete('Pharmacy');
  }

  Future<Config> getAmount() async {
    final _db = await database;
    List<Map<String, dynamic>> results =
        await _db.query('Config', columns: ['name', 'value'], where: 'name = ?', whereArgs: ['amount']);
    return results.map((map) => Config.fromMap(map)).first;
  }

  Future<int> updateAmount(double amount) async {
    final _db = await database;
    int results = await _db.update('Config', {'value': amount}, where: 'name = ?', whereArgs: ['amount']);
    return results;
  }

  Future<Config> getQuantity() async {
    final _db = await database;
    List<Map<String, dynamic>> results =
        await _db.query('Config', columns: ['name', 'value'], where: 'name = ?', whereArgs: ['quantity']);
    return results.map((map) => Config.fromMap(map)).first;
  }

  Future<int> updateQuantity(int quantity) async {
    final _db = await database;
    int results = await _db.update('Config', {'value': quantity}, where: 'name = ?', whereArgs: ['quantity']);
    return results;
  }
}
