import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gosuto/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../utils/account.dart';

class DBHelper {
  static String walletBox = 'wallets';
  static String settingsBox = 'settings';
  static String settingsKey = 'gosuto-settings';
  static Duration cacheDuration = const Duration(minutes: 15);

  static Future<List<int>> getEncrytionKey() async {
    const secureStorage = FlutterSecureStorage();
    final key = await secureStorage.read(key: 'gosuto');

    final encryptionKey = base64Url.decode(key!);
    return encryptionKey;
  }

  static Future<Box<E>> openBox<E>(String boxName) async {
    return await Hive.openBox<E>(boxName,
        encryptionCipher: HiveAesCipher(await getEncrytionKey()));
  }

  static Future<SettingsModel?> getSettings() async {
    try {
      var box = await openBox<SettingsModel>(settingsBox);
      return box.get(settingsKey);
    } catch (e) {
      log('GET SETTINGS ERROR', error: e);
      return null;
    }
  }

  static Future<bool> isSeedPhraseAdded() async {
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

  static Future<String> getPassword() async {
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

  static Future<void> addSettings(SettingsModel settings) async {
    try {
      var box = await openBox<SettingsModel>(settingsBox);
      settings.lastUpdatedTimestamp = DateTime.now().millisecondsSinceEpoch;
      box.put(settingsKey, settings);
    } catch (e) {
      log('INSERT SETTINGS ERROR: ', error: e);
    }
  }

  static Future<int> updateSettings(SettingsModel settings,
      [String? type]) async {
    try {
      var currentSettings = await getSettings();

      if (currentSettings == null) {
        await addSettings(settings);
      } else {
        var box = await openBox<SettingsModel>(settingsBox);
        switch (type) {
          case 'password':
            currentSettings.password = settings.password;
            box.put(settingsKey, currentSettings);
            break;
          case 'all':
          default:
            box.put(settingsKey, settings);
            break;
        }
      }
      return 0;
    } catch (e) {
      log('UPDATE SETTINGS ERROR: ', error: e);
      return -1;
    }
  }

  static Future<bool> isCacheOutdated() async {
    try {
      var box = await openBox<SettingsModel>(settingsBox);
      if (box.isNotEmpty) {
        var settings = box.get(settingsKey);

        if (settings != null) {
          var lastUpdatedTimestamp = settings.lastUpdatedTimestamp;
          var now = DateTime.now().millisecondsSinceEpoch;
          var duration = Duration(milliseconds: now - lastUpdatedTimestamp);

          if (cacheDuration.compareTo(duration) < 0) {
            // update if outdate;
            settings.lastUpdatedTimestamp = now;
            await updateSettings(settings);
            return true;
          } else {
            return false;
          }
        }
      }
      return true;
    } catch (e) {
      return true;
    }
  }

  static Future<Map<dynamic, WalletModel>> getWallets() async {
    try {
      var box = await openBox<WalletModel>(walletBox);
      return box.toMap();
    } catch (e) {
      log('GET ALL WALLETS ERROR: ', error: e);
      return {};
    }
  }

  static Future<int> insertWallet(WalletModel wallet) async {
    try {
      var box = await openBox<WalletModel>(walletBox);
      wallet.id = box.length;
      wallet.balance = await AccountUtils.getBalance(wallet.publicKey, false);
      wallet.totalStake =
          await AccountUtils.getTotalStake(wallet.publicKey, false);
      wallet.totalRewards = await AccountUtils.getTotalRewards(
          wallet.publicKey, wallet.isValidator, false);
      await box.put(wallet.publicKey, wallet);
      return box.length;
    } catch (e) {
      log('INSERT WALLET ERROR: ', error: e);
      return -1;
    }
  }

  static Future<int> getTheLastestWalletId() async {
    var box = await openBox<WalletModel>(walletBox);
    try {
      var id = box.values.isNotEmpty ? box.values.first.id + 1 : box.length;
      return id;
    } catch (e) {
      return box.length;
    }
  }

  static Future<WalletModel?> getWalletByPublicKey(String publicKey) async {
    try {
      var box = await openBox<WalletModel>(walletBox);
      return box.get(publicKey);
    } catch (e) {
      log('GET WALLET BY PUBLIC KEY ERROR: ', error: e);
      return null;
    }
  }

  static Future<bool> isWalletNameExist(String name) async {
    try {
      var box = await openBox<WalletModel>(walletBox);
      var index = box.values.toList().indexWhere((w) => w.name == name);
      return index >= 0;
    } catch (e) {
      log('GET WALLET BY NAME ERROR: ', error: e);
      return false;
    }
  }

  static Future<int> updateWallet(
      {required String publicKey,
      double? balance,
      double? totalStake,
      double? totalRewards}) async {
    try {
      var box = await openBox<WalletModel>(walletBox);
      var index = box.keys.toList().indexOf(publicKey);

      if (index >= 0) {
        var wallet = box.get(publicKey);
        if (wallet != null) {
          if (balance != null) {
            wallet.balance = balance;
          }

          if (totalStake != null) {
            wallet.totalStake = totalStake;
          }

          if (totalRewards != null) {
            wallet.totalRewards = totalRewards;
          }
          await box.put(publicKey, wallet);
        }
      }
      return index;
    } catch (e) {
      log('DELETE WALLET ERROR: ', error: e);
      return -1;
    }
  }

  static Future<void> delete(WalletModel wallet) async {
    try {
      var box = await openBox<WalletModel>(walletBox);
      await box.delete(wallet.publicKey);
    } catch (e) {
      log('DELETE WALLET ERROR: ', error: e);
    }
  }
}
