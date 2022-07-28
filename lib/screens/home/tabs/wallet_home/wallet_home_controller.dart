import 'package:carousel_slider/carousel_controller.dart';
import 'package:casper_dart_sdk/casper_dart_sdk.dart';
import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosuto/data/network/api_client.dart';
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/env/env.dart';
import 'package:gosuto/models/models.dart';
import 'package:convert/convert.dart';
import 'package:gosuto/utils/aes256gcm.dart';

import 'wallet_home.dart';

class WalletHomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  late CarouselController carouselController;
  late ApiClient apiClient;

  var currentTab = WalletHomeTabs.history.obs;
  var isShowBottom = false.obs;
  var walletName = ''.obs;
  var currentPass = ''.obs;
  var newPass = ''.obs;
  var rePass = ''.obs;
  var pass = ''.obs;
  var currentPage = 1.obs;
  var pageCount = 1.obs;
  var itemCount = 0.obs;

  RxList<DeployModel> deploys = RxList<DeployModel>();
  RxList<DeployModel> backupDeploys = RxList<DeployModel>();
  RxList<String> seedPhrases = RxList<String>();
  Rx<SettingsModel>? setting;
  Rx<TransferModel>? selectedTransfer;
  Rx<DeployModel>? selectedDeloy;

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 5, vsync: this);
    carouselController = CarouselController();

    apiClient = ApiClient(Get.find(), baseUrl: env?.baseUrl ?? '');
  }

  void switchTab(index) {
    var tab = _getCurrentTab(index);
    currentTab.value = tab;
  }

  WalletHomeTabs _getCurrentTab(int index) {
    switch (index) {
      case 0:
        return WalletHomeTabs.history;
      case 1:
        return WalletHomeTabs.send;
      case 2:
        return WalletHomeTabs.stake;
      case 3:
        return WalletHomeTabs.walletSettings;
      case 4:
        return WalletHomeTabs.swap;
      default:
        return WalletHomeTabs.history;
    }
  }

  Future updateWallet(WalletModel wallet) async {
    await DBHelper.updateWallet(publicKey: wallet.publicKey);
  }

  Future<void> getAccountDeploys(
    String publicKey, [
    int page = 1,
    int limit = 10,
  ]) async {
    if (page <= pageCount.value) {
      final response = await apiClient.accountDeploys(publicKey, page, limit);
      List<dynamic> data = response.data;

      pageCount(response.pageCount ?? 1);
      itemCount(response.itemCount ?? 0);

      final _deploys = data.map((val) => DeployModel.fromJson(val)).toList();
      if (deploys.isEmpty) {
        deploys(_deploys);
      } else {
        if (currentPage.value < page) {
          // Load more
          deploys.addAll(_deploys);
          currentPage(page);
        }
      }
    }
  }

  Future<void> getSeedPhrase() async {
    bool seedPhraseAdded = await DBHelper.isSeedPhraseAdded();
    if (seedPhraseAdded) {
      String decryptedSeedPhrase = await GosutoAes256Gcm.decrypt(
          setting?.value.seedPhrase ?? '', setting?.value.password ?? '');
      List<String> _seedPhrases = decryptedSeedPhrase.split(' ');
      seedPhrases(_seedPhrases);
    } else {
      seedPhrases([]);
    }
  }

  Future<bool> checkPass(String pass) async {
    Hash hashedPasswordBytes = await Sha1().hash(pass.codeUnits);
    String hashedPassword = hex.encode(hashedPasswordBytes.bytes);
    return hashedPassword == setting?.value.password;
  }

  Future<void> updatePassword() async {
    Hash hashedPasswordBytes = await Sha1().hash(newPass.value.codeUnits);
    String hashedPassword = hex.encode(hashedPasswordBytes.bytes);
    setting?.value.password = hashedPassword;
    setting?.refresh();

    await DBHelper.updateSettings(
      setting!.value,
      'password',
    );

    newPass('');
    currentPass('');
    rePass('');
  }

  Future<void> getDeployInfo(String deployHash) async {
    final deploy = await apiClient.deployInfo(deployHash);
    var isSwapDeploy = deploy.entryPoint?.name.contains('swap') ?? false;

    if (deploy.errorMessage == null &&
        deploy.executionTypeId == 2 &&
        isSwapDeploy) {
      var path = deploy.args['path']['parsed'] as List<dynamic>;

      // Get raw data from chain
      var casperClient =
          CasperClient(env?.rpcUrl ?? 'https://casper-node.tor.us');
      var result = await casperClient.getDeploy(deployHash);
      var transforms = result
          .values.first.executionResults[0].result.success?.effect?.transforms;
      var urefList = transforms != null
          ? transforms.where((element) =>
              element['key'].contains('uref-') && element['transform'] is Map)
          : List<Map<String, dynamic>>.empty();

      if (urefList.isNotEmpty) {
        for (var element in urefList.toList()) {
          try {
            var parsedList =
                element['transform']['WriteCLValue']['parsed'] as List<dynamic>;
            var contractPackageHash = parsedList
                .where((element) => element['key'] == 'contract_package_hash')
                .toList();
            var pairHash = contractPackageHash[0]['value'];

            var amount0In = parsedList
                .where((element) => element['key'] == 'amount0In')
                .toList();
            var amount0Out = parsedList
                .where((element) => element['key'] == 'amount0Out')
                .toList();
            var amount1In = parsedList
                .where((element) => element['key'] == 'amount1In')
                .toList();
            var amount1Out = parsedList
                .where((element) => element['key'] == 'amount1Out')
                .toList();

            var response = await apiClient.getPairInfo(pairHash) as Map;
            if (response.containsKey('data')) {
              var pair = PairModel.fromJson(response['data']);

              if (pair.token0.contractHash == path[0].substring(5)) {
                pair.amount0In = amount0In[0]['value'];
                pair.amount1Out = amount1Out[0]['value'];
              } else {
                pair.amount1In = amount1In[0]['value'];
                pair.amount0Out = amount0Out[0]['value'];
              }
              deploy.pair = pair;
            }
          } catch (e) {
            deploy.pair = null;
          }
        }
      }
    }

    if (selectedDeloy == null) {
      selectedDeloy = deploy.obs;
    } else {
      selectedDeloy!(deploy);
    }
  }
}
