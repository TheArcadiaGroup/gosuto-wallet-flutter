import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gosuto/services/service.dart';
import 'package:gosuto/themes/colors.dart';
import 'package:gosuto/utils/utils.dart';

import 'create_wallet_controller.dart';

class CreateWalletScreen extends GetView<CreateWalletController> {
  const CreateWalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                SvgPicture.asset('assets/images/logo.svg'),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'create_a_new_wallet'.tr,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'create_a_password'.tr,
                        style: AppConstants.subTextStyle,
                      ),
                      Text(
                        'create_a_password_text1'.tr,
                        style: AppConstants.subTextStyle,
                      ),
                      Text(
                        'create_a_password_text2'.tr,
                        style: AppConstants.subTextStyle,
                      ),
                    ],
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
