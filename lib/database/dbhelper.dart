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

  Future<List<Wallet>> getWallets() async {
    Database db = await initDB();
    List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM $_table');

    List<Wallet> wallets = [];
    if (maps.isNotEmpty) {
      for (var element in maps) {
        wallets.add(Wallet.fromMap(element));
      }
      return maps.map((e) => Wallet.fromMap(e)).toList();
    }

    return wallets;
  }

  Future<int> delete(int id) async {
    Database db = await initDB();
    return await db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map>> getAllWallets() async {
    try {
      Database db = await initDB();
      List<Map> wallets = await db.query('wallets');
      return wallets;
    } catch (e) {
      log('GET ALL WALLETS ERROR: ', error: e);
      return [];
    }
  }

  Future<List<Map>?> getWalletById(int id) async {
    try {
      Database db = await initDB();
      List<Map> wallet =
          await db.query('wallets', where: 'id = ?', whereArgs: [id]);
      return wallet;
    } catch (e) {
      log('GET WALLET BY ID ERROR: ', error: e);
      return null;
    }
  }

  Future<int> update(Wallet wallet) async {
    Database db = await initDB();

    return await db.update(_table, wallet.toMap(),
        where: 'id = ?', whereArgs: [wallet.id]);
  }
}
