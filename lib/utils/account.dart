import 'package:casper_dart_sdk/casper_dart_sdk.dart';
import 'package:get/get.dart';
import 'package:gosuto/data/network/api_client.dart';
import 'package:gosuto/env/env.dart';

class AccountUtils {
  static Future<double> fetchBalance(String publicKey) async {
    try {
      var casperClient = CasperClient('https://casper-node.tor.us');
      var clPublicKey = CLPublicKey.fromHex(publicKey);
      var balance = await casperClient.balanceOfByPublicKey(clPublicKey);

      return CasperClient.fromWei(balance).toDouble();
    } catch (e) {
      return 0;
    }
  }

  static Future<double> getTotalStake(String publicKey) async {
    var totalStake = zeroBN;
    var apiClient = ApiClient(Get.find(), baseUrl: env?.baseUrl ?? '');

    try {
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
                totalStake =
                    totalStake.add(BigNumber.from(delegators[j].stakedAmount));
              }
            }
          }
        }
      }

      return CasperClient.fromWei(totalStake).toDouble();
    } catch (e) {
      return 0;
    }
  }

  static Future<double> getTotalRewards(
      String publicKey, int isValidator) async {
    var totalRewards = zeroBN;
    var apiClient = ApiClient(Get.find(), baseUrl: env?.baseUrl ?? '');

    try {
      var response = await apiClient.totalRewards(
          publicKey, isValidator == 1 ? 'validators' : 'delegators');
      if (response['data'] != '') {
        totalRewards = BigNumber.from(response['data']);
      }
      return CasperClient.fromWei(totalRewards).toDouble();
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
