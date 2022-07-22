import 'package:casper_dart_sdk/casper_dart_sdk.dart';
import 'package:get/get.dart';
import 'package:gosuto/data/network/api_client.dart';
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/env/env.dart';
import 'package:gosuto/models/wallet_model.dart';

class AccountUtils {
  static Future<void> getAllBalances(bool loadFromCache) async {
    var wallets = await DBHelper.getWallets();
    for (var i = 0; i < wallets.length; i++) {
      var list = wallets.values.toList();
      var w = list[i];
      await getBalance(w.publicKey, loadFromCache);
    }
  }

  static Future<double> getBalance(String publicKey, bool loadFromCache) async {
    try {
      var isOutdated = await DBHelper.isCacheOutdated();
      if (loadFromCache && !isOutdated) {
        var wallet = await DBHelper.getWalletByPublicKey(publicKey);
        return wallet != null ? wallet.balance : 0;
      } else {
        var casperClient =
            CasperClient(env?.rpcUrl ?? 'https://casper-node.tor.us');
        var clPublicKey = CLPublicKey.fromHex(publicKey);
        var balance = await casperClient.balanceOfByPublicKey(clPublicKey);
        var balanceDouble = CasperClient.fromWei(balance).toDouble();

        await DBHelper.updateWallet(
            publicKey: publicKey, balance: balanceDouble);
        return balanceDouble;
      }
    } catch (e) {
      return 0;
    }
  }

  static Future<void> getAllTotalStakes(bool loadFromCache) async {
    var wallets = await DBHelper.getWallets();
    for (var i = 0; i < wallets.length; i++) {
      var list = wallets.values.toList();
      var w = list[i];
      await getTotalStake(w.publicKey, loadFromCache);
    }
  }

  static Future<double> getTotalStake(
      String publicKey, bool loadFromCache) async {
    var totalStake = zeroBN;
    var apiClient = ApiClient(Get.find(), baseUrl: env?.baseUrl ?? '');

    try {
      var isOutdated = await DBHelper.isCacheOutdated();
      if (loadFromCache && !isOutdated) {
        var wallet = await DBHelper.getWalletByPublicKey(publicKey);
        return wallet != null ? wallet.totalStake : 0;
      } else {
        var response = await apiClient.stateAuctionInfo();
        var auctionInfo =
            AuctionState.fromJson(response['result']['auction_state']);
        if (auctionInfo.bids.isNotEmpty) {
          var publicKeyHex = publicKey..toLowerCase();
          var bids = auctionInfo.bids;
          for (var i = 0; i < bids.length; i++) {
            if (bids[i].publicKey.toLowerCase() == publicKeyHex) {
              totalStake =
                  totalStake.add(BigNumber.from(bids[i].bid.stakedAmount));
            }

            var delegators = bids[i].bid.delegators;
            if (delegators.isNotEmpty) {
              for (var j = 0; j < delegators.length; j++) {
                if (delegators[j].publicKey == publicKeyHex) {
                  totalStake = totalStake
                      .add(BigNumber.from(delegators[j].stakedAmount));
                }
              }
            }
          }
        }

        var totalStakeDouble = CasperClient.fromWei(totalStake).toDouble();
        await DBHelper.updateWallet(
            publicKey: publicKey, totalStake: totalStakeDouble);
        return totalStakeDouble;
      }
    } catch (e) {
      return 0;
    }
  }

  static Future<void> getAllTotalRewards(bool loadFromCache) async {
    var wallets = await DBHelper.getWallets();
    for (var i = 0; i < wallets.length; i++) {
      var list = wallets.values.toList();
      var w = list[i];
      await getTotalRewards(w.publicKey, w.isValidator, loadFromCache);
    }
  }

  static Future<double> getTotalRewards(
      String publicKey, bool isValidator, bool loadFromCache) async {
    var totalRewards = zeroBN;
    var apiClient = ApiClient(Get.find(), baseUrl: env?.baseUrl ?? '');

    try {
      var isOutdated = await DBHelper.isCacheOutdated();
      if (loadFromCache && !isOutdated) {
        var wallet = await DBHelper.getWalletByPublicKey(publicKey);
        return wallet != null ? wallet.totalRewards : 0;
      } else {
        var response = await apiClient.totalRewards(
            publicKey, isValidator ? 'validators' : 'delegators');
        if (response['data'] != '') {
          totalRewards = BigNumber.from(response['data']);
        }
        var totalRewardsDouble = CasperClient.fromWei(totalRewards).toDouble();
        print('==totalRewardsDouble==');
        print(totalRewardsDouble);
        await DBHelper.updateWallet(
            publicKey: publicKey, totalRewards: totalRewardsDouble);
        return totalRewardsDouble;
      }
    } catch (e) {
      return 0;
    }
  }

  static Future<bool> isValidator(String accountHash) async {
    var isValidator = false;
    var apiClient = ApiClient(Get.find(), baseUrl: env?.baseUrl ?? '');

    try {
      var response = await apiClient.accountsInfo(accountHash);
      if (response['data']['account_hash'].toString().toLowerCase() ==
          accountHash.toLowerCase()) {
        isValidator = true;
      }
      return isValidator;
    } catch (e) {
      return false;
    }
  }
}
