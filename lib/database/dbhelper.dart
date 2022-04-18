import 'dart:developer';

import 'package:gosuto/models/settings.dart';
import 'package:gosuto/models/wallet.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static late Database _db;
  static const _dbName = 'gosuto.db';

  Future<Database> get db async {
    _db = await initDB();
    return _db;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), _dbName);
    // print(path);
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE settings(
      seedPhrase TEXT DEFAULT '',
      password TEXT DEFAULT '',
      useBiometricAuth INT DEFAULT 0
    )''');
    await db.execute('''CREATE TABLE wallets(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          walletName TEXT NOT NULL UNIQUE,
          publicKey TEXT NOT NULL UNIQUE,
          accountHash TEXT NOT NULL UNIQUE,
          privateKey TEXT NOT NULL UNIQUE
        )''');
  }

  Future<List<Map<String, dynamic>>> getSettings() async {
    try {
      Database db = await initDB();
      var settings = await db.query('settings');
      return settings;
    } catch (e) {
      log('GET SETTINGS ERROR', error: e);
      return [];
    }
  }

  Future<bool> isSeedPhraseAdded() async {
    try {
      var data = await getSettings();
      if (data.isNotEmpty) {
        Settings _settings = Settings.fromMap(data[0]);
        return _settings.seedPhrase != '';
      }
      return false;
    } catch (e) {
      log('CHECK SEED PHRASE ADDED ERROR: ', error: e);
      return false;
    }
  }

  Future<String> getPassword() async {
    final _data = await getSettings();

    if (_data.isNotEmpty) {
      Settings _settings = Settings.fromMap(_data[0]);
      return _settings.password;
    }

    return '';
  }

  Future<int> insertSettings(Settings settings) async {
    try {
      Database db = await initDB();
      int settingsId = await db.insert('settings', settings.toMap());
      return settingsId;
    } catch (e) {
      log('INSERT SETTINGS ERROR: ', error: e);
      return -1;
    }
  }

  Future<int> updateSettings(Settings settings, [String? type]) async {
    try {
      var currentSettings = await getSettings();

      if (currentSettings.isEmpty) {
        return await insertSettings(settings);
      } else {
        Database db = await initDB();
        String query = '';
        List<dynamic> args = [];

        switch (type) {
          case 'password':
            query = 'UPDATE settings SET password = ?';
            args = [settings.password];
            break;
          case 'all':
          default:
            query =
                'UPDATE settings SET seedPhrase = ?, password = ?, useBiometricAuth = ?';
            args = [
              settings.seedPhrase,
              settings.password,
              settings.useBiometricAuth,
            ];
            break;
        }

        int result = await db.rawUpdate(query, args);
        return result;
      }
    } catch (e) {
      log('UPDATE SETTINGS ERROR: ', error: e);
      return -1;
    }
  }

  Future<int> insertWallet(Wallet wallet) async {
    try {
      Database db = await initDB();
      int walletId = await db.insert('wallets', wallet.toMap());
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
    try {
      Database db = await initDB();
      List<Map<String, dynamic>> maps = await db.query('wallets');

      List<Wallet> wallets = [];
      if (maps.isNotEmpty) {
        for (var element in maps) {
          wallets.add(Wallet.fromMap(element));
        }
        return maps.map((e) => Wallet.fromMap(e)).toList();
      }

      return wallets;
    } catch (e) {
      log('GET ALL WALLETS ERROR: ', error: e);
      return [];
    }
  }

  Future<int> delete(int id) async {
    Database db = await initDB();
    return await db.delete('wallets', where: 'id = ?', whereArgs: [id]);
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

  Future<List<Map>> getWalletsBySeedPhrase(String seedphrase) async {
    try {
      Database db = await initDB();
      List<Map> wallet = await db
          .query('wallets', where: 'seedPhrase = ?', whereArgs: [seedphrase]);
      return wallet;
    } catch (e) {
      log('GET WALLET BY SEED PHRASE ERROR: ', error: e);
      return [];
    }
  }

  Future<int> getTheLastestWalletId() async {
    try {
      Database db = await initDB();
      List<Map> data = await db
          .query('sqlite_sequence', where: 'name = ?', whereArgs: ['wallets']);
      if (data.isNotEmpty) {
        return data[0]['seq'];
      }
      return 0;
    } catch (e) {
      log('GET LATEST WALLET ID ERROR: ', error: e);
      return 0;
    }
  }

  Future<List<Map>> getWalletByPrivateKey(String privateKey) async {
    try {
      Database db = await initDB();
      List<Map> wallet = await db
          .query('wallets', where: 'privateKey = ?', whereArgs: [privateKey]);
      return wallet;
    } catch (e) {
      log('GET WALLET BY PRIVATE KEY ERROR: ', error: e);
      return [];
    }
  }

  Future<int> update(Wallet wallet) async {
    Database db = await initDB();

    return await db.update('wallets', wallet.toMap(),
        where: 'id = ?', whereArgs: [wallet.id]);
  }
}
