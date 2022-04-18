import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gosuto/components/button.dart';
import 'package:gosuto/components/radio_option.dart';
import 'package:gosuto/database/dbhelper.dart';
import 'package:gosuto/routes/routes.dart';
import 'package:gosuto/utils/utils.dart';
import 'add_wallet_controller.dart';

class AddWalletScreen extends GetView<AddWalletController> {
  const AddWalletScreen({Key? key}) : super(key: key);

  ValueChanged<int?> _onMethodChanged() {
    return (value) => controller.updateAddWalletMethod(value);
  }

  void _onNextPressed() {
    switch (controller.methodId.value) {
      case 1:
        Get.toNamed(Routes.createWallet);
        break;
      case 2:
        Get.toNamed(Routes.importSeed);
        break;
      case 3:
        Get.toNamed(Routes.importFile);
        break;
      case 4:
        Get.toNamed(Routes.importPk);
        break;
      default:
        Get.toNamed(Routes.createWallet);
        break;
    }
  }

  Widget _buildForm() {
    List<Widget> widgets = [
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
    ];
    return FutureBuilder(
      future: DBHelper().isSeedPhraseAdded(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data == true) {
              widgets.add(
                Obx(
                  () => GosutoRadioOption(
                    value: 4,
                    groupValue: controller.methodId.value,
                    label: 'wallet_title2_pk'.tr,
                    text: 'wallet_text2_pk'.tr,
                    onChanged: _onMethodChanged(),
                  ),
                ),
              );
            } else {
              widgets.add(
                Obx(
                  () => GosutoRadioOption(
                    value: 2,
                    groupValue: controller.methodId.value,
                    label: 'wallet_title2'.tr,
                    text: 'wallet_text2'.tr,
                    onChanged: _onMethodChanged(),
                  ),
                ),
              );
            }
          }

          widgets.addAll([
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
            )
          ]);
        }

        return Column(
          children: widgets,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _build(context),
    );
  }

  Widget _build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SvgPicture.asset('assets/images/logo.svg'),
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
              Expanded(
                flex: 4,
                child: ListView(
                  children: [
                    _buildForm(),
                  ],
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
      ),
    );
  }
}
