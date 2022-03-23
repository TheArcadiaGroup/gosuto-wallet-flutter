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
          walletName TEXT NOT NULL,
          publicKey TEXT NOT NULL,
          cipherText TEXT NOT NULL,
          secretKey BLOB NOT NULL,
          nonce TEXT BLOB NULL
        )''');
  }

  Future<int> insertWallet(Wallet wallet) async {
    Database db = await initDB();
    int walletId = await db.insert(_table, wallet.toMap());
    await db.close();
    return walletId;
  }
}
