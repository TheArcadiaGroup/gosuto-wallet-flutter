import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gosuto/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DBHelper {
  final String walletBox = 'wallets';
  final String settingsBox = 'settings';

  Future<List<int>> getEncrytionKey() async {
    const secureStorage = FlutterSecureStorage();
    final key = await secureStorage.read(key: 'gosuto');

    final encryptionKey = base64Url.decode(key!);
    return encryptionKey;
  }

  Future<Box<E>> openBox<E>(String boxName) async {
    return await Hive.openBox<E>(boxName,
        encryptionCipher: HiveAesCipher(await getEncrytionKey()));
  }

  Future<SettingsModel?> getSettings() async {
    try {
      var box = await openBox<SettingsModel>(settingsBox);
      return box.values.isNotEmpty ? box.values.first : null;
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
      var box = await openBox<SettingsModel>(settingsBox);
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
        var box = await openBox<SettingsModel>(settingsBox);
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
      var box = await openBox<WalletModel>(walletBox);
      return box.toMap();
    } catch (e) {
      log('GET ALL WALLETS ERROR: ', error: e);
      return {};
    }
  }

  Future<int> insertWallet(WalletModel wallet) async {
    try {
      var box = await openBox<WalletModel>(walletBox);
      wallet.id = box.length;
      await box.put(wallet.publicKey, wallet);
      return box.length;
    } catch (e) {
      log('INSERT WALLET ERROR: ', error: e);
      return -1;
    }
  }

  Future<int> getTheLastestWalletId() async {
    var box = await openBox<WalletModel>(walletBox);
    try {
      var id = box.values.isNotEmpty ? box.values.first.id + 1 : box.length;
      return id;
    } catch (e) {
      return box.length;
    }
  }

  Future<WalletModel?> getWalletByPublicKey(String publicKey) async {
    try {
      var box = await openBox<WalletModel>(walletBox);
      return box.get(publicKey);
    } catch (e) {
      log('GET WALLET BY PUBLIC KEY ERROR: ', error: e);
      return null;
    }
  }

  Future<bool> isWalletNameExist(String name) async {
    try {
      var box = await openBox<WalletModel>(walletBox);
      var index = box.values.toList().indexWhere((w) => w.name == name);
      return index >= 0;
    } catch (e) {
      log('GET WALLET BY NAME ERROR: ', error: e);
      return false;
    }
  }

  Future<int> update(WalletModel wallet) async {
    try {
      var box = await openBox<WalletModel>(walletBox);
      var index = box.keys.toList().indexOf(wallet.publicKey);

      if (index >= 0) {
        await box.putAt(index, wallet);
      }
      return index;
    } catch (e) {
      log('DELETE WALLET ERROR: ', error: e);
      return -1;
    }
  }

  Future<void> delete(WalletModel wallet) async {
    try {
      var box = await openBox<WalletModel>(walletBox);
      await box.delete(wallet.publicKey);
    } catch (e) {
      log('DELETE WALLET ERROR: ', error: e);
    }
  }
}
