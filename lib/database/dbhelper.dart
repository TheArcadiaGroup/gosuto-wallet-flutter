import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gosuto/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DBHelper {
  final String walletBox = 'wallets';
  final String settingsBox = 'settings';

  Future<List<int>> _getEncrytionKey() async {
    const secureStorage = FlutterSecureStorage();
    final key = await secureStorage.read(key: 'gosuto');

    final encryptionKey = base64Url.decode(key!);
    return encryptionKey;
  }

  Future<SettingsModel?> getSettings() async {
    try {
      var settings = await Hive.openBox<SettingsModel>(settingsBox,
          encryptionCipher: HiveAesCipher(await _getEncrytionKey()));
      return settings.values.isNotEmpty ? settings.values.first : null;
    } catch (e) {
      log('GET SETTINGS ERROR', error: e);
      return null;
    }
  }

  Future<bool> isSeedPhraseAdded() async {
    try {
      var settings = await getSettings();
      if (settings != null) {
        return settings.seedPhrase != '';
      }
      return false;
    } catch (e) {
      log('CHECK SEED PHRASE ADDED ERROR: ', error: e);
      return false;
    }
  }

  Future<String> getPassword() async {
    try {
      var settings = await getSettings();
      if (settings != null) {
        return settings.password;
      }
      return '';
    } catch (e) {
      log('GET PASSWORD: ', error: e);
      return '';
    }
  }

  Future<int> insertSettings(SettingsModel settings) async {
    try {
      var box = await Hive.openBox<SettingsModel>(settingsBox,
          encryptionCipher: HiveAesCipher(await _getEncrytionKey()));
      return box.add(settings);
    } catch (e) {
      log('INSERT SETTINGS ERROR: ', error: e);
      return -1;
    }
  }

  Future<int> updateSettings(SettingsModel settings, [String? type]) async {
    try {
      var currentSettings = await getSettings();

      if (currentSettings == null) {
        await insertSettings(settings);
      } else {
        var box = await Hive.openBox<SettingsModel>(settingsBox,
            encryptionCipher: HiveAesCipher(await _getEncrytionKey()));
        switch (type) {
          case 'password':
            currentSettings.password = settings.password;
            box.putAt(0, currentSettings);
            break;
          case 'all':
          default:
            box.putAt(0, settings);
            break;
        }
      }
      return 0;
    } catch (e) {
      log('UPDATE SETTINGS ERROR: ', error: e);
      return -1;
    }
  }

  Future<Map<dynamic, WalletModel>> getWallets() async {
    try {
      var wallets = await Hive.openBox<WalletModel>(walletBox,
          encryptionCipher: HiveAesCipher(await _getEncrytionKey()));
      return wallets.toMap();
    } catch (e) {
      log('GET ALL WALLETS ERROR: ', error: e);
      return {};
    }
  }

  Future<int> insertWallet(WalletModel wallet) async {
    try {
      var wallets = await Hive.openBox<WalletModel>(walletBox,
          encryptionCipher: HiveAesCipher(await _getEncrytionKey()));
      wallet.id = wallets.length;
      await wallets.put(wallet.publicKey, wallet);
      return wallets.length;
    } catch (e) {
      log('INSERT WALLET ERROR: ', error: e);
      return -1;
    }
  }

  Future<int> getTheLastestWalletId() async {
    var box = await Hive.openBox<WalletModel>(walletBox,
        encryptionCipher: HiveAesCipher(await _getEncrytionKey()));
    try {
      var id = box.values.isNotEmpty ? box.values.first.id + 1 : box.length;
      return id;
    } catch (e) {
      return box.length;
    }
  }

  Future<WalletModel?> getWalletByPublicKey(String publicKey) async {
    try {
      var wallets = await Hive.openBox<WalletModel>(walletBox,
          encryptionCipher: HiveAesCipher(await _getEncrytionKey()));
      return wallets.get(publicKey);
    } catch (e) {
      log('GET WALLET BY PUBLIC KEY ERROR: ', error: e);
      return null;
    }
  }

  Future<bool> isWalletNameExist(String name) async {
    try {
      var wallets = await Hive.openBox<WalletModel>(walletBox,
          encryptionCipher: HiveAesCipher(await _getEncrytionKey()));
      var index = wallets.values.toList().indexWhere((w) => w.name == name);
      return index >= 0;
    } catch (e) {
      log('GET WALLET BY NAME ERROR: ', error: e);
      return false;
    }
  }

  Future<int> update(WalletModel wallet) async {
    try {
      var wallets = await Hive.openBox<WalletModel>(walletBox,
          encryptionCipher: HiveAesCipher(await _getEncrytionKey()));
      var index = wallets.keys.toList().indexOf(wallet.publicKey);

      if (index >= 0) {
        await wallets.putAt(index, wallet);
      }
      return index;
    } catch (e) {
      log('DELETE WALLET ERROR: ', error: e);
      return -1;
    }
  }

  Future<void> delete(WalletModel wallet) async {
    try {
      var wallets = await Hive.openBox<WalletModel>(walletBox,
          encryptionCipher: HiveAesCipher(await _getEncrytionKey()));
      await wallets.delete(wallet.publicKey);
    } catch (e) {
      log('DELETE WALLET ERROR: ', error: e);
    }
  }
}
