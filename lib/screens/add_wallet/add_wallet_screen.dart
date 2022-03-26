import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gosuto/components/button.dart';
import 'package:gosuto/components/radio_option.dart';
import 'add_wallet_controller.dart';

class AddWalletScreen extends GetView<AddWalletController> {
  const AddWalletScreen({Key? key}) : super(key: key);

  ValueChanged<int?> _onMethodChanged() {
    return (value) => controller.updateAddWalletMethod(value);
  }

  void _onNextPressed() {
    switch (controller.methodId.value) {
      case 1:
        Get.toNamed('/create_wallet');
        break;
      case 2:
        Get.toNamed('/import_seed');
        break;
      case 3:
        Get.offNamed('/import_seed');
        break;
      default:
        Get.toNamed('/create_wallet');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _build(context),
    );
  }

  Widget _build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SvgPicture.asset('assets/images/logo.svg'),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'add_wallet'.tr,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'add_wallet_hello'.tr,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Obx(
                      () => GosutoRadioOption(
                        value: 1,
                        groupValue: controller.methodId.value,
                        label: 'wallet_title1'.tr,
                        text: 'wallet_text1'.tr,
                        onChanged: _onMethodChanged(),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Obx(
                      () => GosutoRadioOption(
                        value: 2,
                        groupValue: controller.methodId.value,
                        label: 'wallet_title2'.tr,
                        text: 'wallet_text2'.tr,
                        onChanged: _onMethodChanged(),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Obx(
                      () => GosutoRadioOption(
                        value: 3,
                        groupValue: controller.methodId.value,
                        label: 'wallet_title3'.tr,
                        text: 'wallet_text3'.tr,
                        onChanged: _onMethodChanged(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(
                () => GosutoButton(
                  text: 'okay'.tr,
                  style: GosutoButtonStyle.fill,
                  disabled: controller.methodId.value == 0,
                  onPressed: _onNextPressed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
