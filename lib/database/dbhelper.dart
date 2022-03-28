import 'dart:developer';

import 'package:gosuto/models/wallet.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static late Database _db;
  static const _dbName = 'gosuto.db';
  static const _table = 'wallets';

  Future<Database> get db async {
    _db = await initDB();
    return _db;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), _dbName);
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE wallets(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          walletName TEXT NOT NULL UNIQUE,
          password TEXT NOT NULL,
          publicKey TEXT NOT NULL UNIQUE,
          accountHash TEXT NOT NULL UNIQUE,
          cipherText TEXT NOT NULL UNIQUE
        )''');
  }

  Future<int> insertWallet(Wallet wallet) async {
    try {
      Database db = await initDB();
      int walletId = await db.insert(_table, wallet.toMap());
      await db.close();
      return walletId;
    } catch (e) {
      log('INSERT WALLET ERROR: ', error: e);
      return -1;
    }
  }

  Future<bool> isWalletNameExist(String name) async {
    try {
      Database db = await initDB();
      List<Map> wallets =
          await db.query('wallets', where: 'walletName = ?', whereArgs: [name]);
      return wallets.isNotEmpty;
    } catch (e) {
      log('GET WALLET BY NAME ERROR: ', error: e);
      return false;
    }
  }
}
