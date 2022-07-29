import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosuto/models/wallet_model.dart';
import 'package:gosuto/screens/home/home.dart';

class TokenList extends GetView<HomeController> {
  TokenList({Key? key, required this.wallet}) : super(key: key);

  final WalletModel wallet;
  final WalletHomeController _whController = Get.put(WalletHomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18, bottom: 10, right: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('tokens_in_this_wallet'.tr,
                  style: Theme.of(context).textTheme.headline1),
              SizedBox(
                height: 36,
                child: ElevatedButton.icon(
                  icon: Image.asset('assets/images/ic-add-no-bg.png'),
                  label: Text('add_token'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(color: Colors.white, fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
