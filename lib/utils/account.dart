import 'package:casper_dart_sdk/casper_dart_sdk.dart';
import 'package:get/get.dart';
import 'package:gosuto/data/network/api_client.dart';
import 'package:gosuto/env/env.dart';

class AccountUtils {
  static Future<double> fetchBalance(String publicKeyHex) async {
    try {
      var casperClient = CasperClient('https://casper-node.tor.us');
      var publicKey = CLPublicKey.fromHex(publicKeyHex);
      var balance = await casperClient.balanceOfByPublicKey(publicKey);

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
      print(e);
      return 0;
    }
  }
}
