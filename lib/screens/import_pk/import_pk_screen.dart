import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gosuto/components/button.dart';
import 'package:gosuto/components/checkbox.dart';
import 'package:gosuto/components/dialog.dart';
import 'package:gosuto/routes/app_pages.dart';
import 'package:gosuto/services/theme_service.dart';
import 'package:gosuto/themes/colors.dart';
import 'package:gosuto/utils/utils.dart';

import 'import_pk_controller.dart';

class ImportPkScreen extends GetView<ImportPkController> {
  const ImportPkScreen({Key? key}) : super(key: key);

  Future<void> _onContinue(context) async {
    var obj = await controller.checkValidate();

    if (obj['isValid']) {
      controller.formKey.currentState?.save();

      // save wallet to db
      int walletId = await controller.createWallet();

      if (walletId > 0) {
        Get.offAllNamed(Routes.home);
      } else {
        GosutoDialog().buildDialog(context, [
          Text(
            'create_wallet_failed'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ThemeService().isDarkMode
                  ? Colors.white
                  : const Color(0xFF121826),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          GosutoButton(
            text: 'confirm'.tr,
            style: GosutoButtonStyle.fill,
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          )
        ]);
      }
    } else {
      GosutoDialog().buildDialog(context, [
        Text(
          obj['errorMessage'],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ThemeService().isDarkMode
                ? Colors.white
                : const Color(0xFF121826),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(30),
        ),
        GosutoButton(
          text: 'confirm'.tr,
          style: GosutoButtonStyle.fill,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        )
      ]);
    }
  }

  Widget _buildForm(context) {
    InputDecoration _inputDecoration = AppConstants.getInputDecoration(context);

    List<Widget> widgets = [
      SizedBox(
        height: getProportionateScreenHeight(30),
      ),
      TextFormField(
        controller: controller.walletNameController,
        cursorColor: Theme.of(context).colorScheme.onSurface,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: _inputDecoration.copyWith(
          labelText: 'wallet_name'.tr,
        ),
        onChanged: (value) {
          controller.walletName.value = value;
        },
        onSaved: (value) {
          controller.walletName.value = value!;
        },
        validator: (value) {
          return controller.validateWalletName(value!);
        },
      ),
      SizedBox(
        height: getProportionateScreenHeight(30),
      ),
      TextFormField(
        controller: controller.privateKeyController,
        cursorColor: Theme.of(context).colorScheme.onSurface,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: _inputDecoration.copyWith(
            labelText: 'private_key'.tr,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      var clipboardData =
                          await Clipboard.getData(Clipboard.kTextPlain);
                      controller.privateKey.value = clipboardData!.text!;
                      controller.privateKeyController.text =
                          clipboardData.text!;
                    },
                    child: Text(
                      'paste'.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppDarkColors.orangeColor,
                      ),
                    ),
                  )
                ],
              ),
            )),
        onChanged: (value) {
          controller.privateKey.value = value;
        },
        onSaved: (value) {
          controller.privateKey.value = value!;
        },
        validator: (value) {
          return controller.validateSeedPhrase(value!);
        },
      ),
      SizedBox(
        height: getProportionateScreenHeight(30),
      ),
      Obx(
        () => GosutoCheckbox(
          label: 'confirm_text'.tr,
          isChecked: controller.agreed.value,
          onChanged: (value) => controller.toggleAgreed(),
        ),
      )
    ];

    return Form(
      key: controller.formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: widgets,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                SvgPicture.asset('assets/images/logo.svg'),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Text(
                  'import_your_wallet'.tr,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  flex: 4,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(30),
                      ),
                      _buildForm(context),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(40),
                      ),
                      Obx(
                        () => GosutoButton(
                          text: 'continue'.tr,
                          style: GosutoButtonStyle.fill,
                          disabled: !controller.agreed.value,
                          onPressed: () async {
                            _onContinue(context);
                          },
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      GosutoButton(
                        text: 'back'.tr,
                        style: GosutoButtonStyle.text,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
