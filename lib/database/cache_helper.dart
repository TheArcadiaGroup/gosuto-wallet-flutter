import 'dart:developer';

import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/models/models.dart';

class CacheHelper extends DBHelper {
  final String cacheBox = 'caches';

  final Duration cacheDuration = const Duration(minutes: 15);

  Future<void> addCache(RPCCacheModel cache) async {
    try {
      var box = await openBox<RPCCacheModel>(cacheBox);
      box.add(cache);
    } catch (e) {
      log('ADD CACHE ERROR: ', error: e);
    }
  }

  Future<bool> isOutdated() async {
    try {
      var box = await openBox<RPCCacheModel>(cacheBox);
      if (box.isNotEmpty) {
        var cache = box.getAt(0);

        if (cache != null) {
          var lastTimestamp = cache.lastTimestamp;
          var now = DateTime.now().millisecondsSinceEpoch;
          var duration = Duration(milliseconds: now - lastTimestamp);

          if (cacheDuration.compareTo(duration) < 0) {
            // update if outdate;
            cache.lastTimestamp = now;
            box.putAt(0, cache);
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

  Future<void> updateBalanceCache(Map<String, dynamic> map) async {
    try {
      var box = await openBox<RPCCacheModel>(cacheBox);
      if (box.isNotEmpty) {
        //   var cache = RPCCacheModel(balance: List.empty(growable: true));
        //   cache.balance = List<Map<String, dynamic>>.empty(growable: true);
        //   cache.balance.add(map);
        //   print(cache.balance.toList());
        //   await addCache(cache);
        // } else {
        var currentCache = box.getAt(0);
        if (currentCache != null) {
          var index = currentCache.balance
              .indexWhere((e) => e['public_key'] == map['public_key']);
          if (index >= 0) {
            currentCache.balance[index]['balance'] = map['balance'];
          } else {
            currentCache.balance.add(map);
          }

          box.putAt(0, currentCache);
        }
      }
    } catch (e) {
      log('UPDATE CACHE ERROR: ', error: e);
    }
  }

  Future<bool> isBalanceCacheExist(String publicKey) async {
    try {
      var box = await openBox<RPCCacheModel>(cacheBox);
      if (box.isNotEmpty) {
        var currentCache = box.getAt(0);
        if (currentCache != null) {
          var index = currentCache.balance
              .indexWhere((e) => e['public_key'] == publicKey);
          return index >= 0;
        }
      }
      return false;
    } catch (e) {
      log('FIND CACHE ERROR: ', error: e);
      return false;
    }
  }

  Future<double> getBalanceByPublicKey(String publicKey) async {
    try {
      var box = await openBox<RPCCacheModel>(cacheBox);
      if (box.isNotEmpty) {
        var currentCache = box.getAt(0);
        if (currentCache != null) {
          var index = currentCache.balance
              .indexWhere((e) => e['public_key'] == publicKey);
          var balance = currentCache.balance.elementAt(index);
          return balance['balance'];
        }
      }
      return 0;
    } catch (e) {
      log('GET BALANCE CACHE ERROR: ', error: e);
      return 0;
    }
  }
}
