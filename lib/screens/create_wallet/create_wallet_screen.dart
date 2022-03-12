import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gosuto/services/service.dart';
import 'package:gosuto/utils/utils.dart';

import '../../components/button.dart';
import '../../components/checkbox.dart';
import 'create_wallet_controller.dart';

class CreateWalletScreen extends GetView<CreateWalletController> {
  const CreateWalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InputDecoration _inputDecoration = InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
      contentPadding: const EdgeInsets.all(20),
      border: OutlineInputBorder(
        borderSide:
            BorderSide(color: Theme.of(context).colorScheme.onSecondary),
        borderRadius: const BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Theme.of(context).colorScheme.onSecondary),
        borderRadius: const BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Theme.of(context).colorScheme.onSecondary),
        borderRadius: const BorderRadius.all(
          Radius.circular(24),
        ),
      ),
    );

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
                Row(
                  children: <Widget>[
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
                  ],
                ),
                Expanded(
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 30,
                              ),
                              TextField(
                                controller: controller.walletNameController,
                                cursorColor:
                                    Theme.of(context).colorScheme.onSurface,
                                style: Theme.of(context).textTheme.bodyText1,
                                decoration: _inputDecoration.copyWith(
                                  labelText: 'wallet_name'.tr,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Obx(
                                () => TextField(
                                  obscureText: controller.hidePassword.value,
                                  cursorColor:
                                      Theme.of(context).colorScheme.onSurface,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  decoration: _inputDecoration.copyWith(
                                    labelText: 'wallet_paddword'.tr,
                                    prefixIcon: IconButton(
                                      icon: ThemeService().isDarkMode
                                          ? SvgPicture.asset(
                                              'assets/svgs/dark/ic-lock.svg')
                                          : SvgPicture.asset(
                                              'assets/svgs/light/ic-lock.svg'),
                                      onPressed: null,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(controller.hidePassword.value
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () =>
                                          controller.togglePassword(),
                                      color: ThemeService().isDarkMode
                                          ? Colors.white.withOpacity(0.4)
                                          : Colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Obx(
                                () => TextField(
                                  obscureText: controller.hideRePassword.value,
                                  cursorColor:
                                      Theme.of(context).colorScheme.onSurface,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  decoration: _inputDecoration.copyWith(
                                    labelText: 'wallet_paddword2'.tr,
                                    prefixIcon: IconButton(
                                      icon: ThemeService().isDarkMode
                                          ? SvgPicture.asset(
                                              'assets/svgs/dark/ic-lock.svg')
                                          : SvgPicture.asset(
                                              'assets/svgs/light/ic-lock.svg'),
                                      onPressed: null,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(controller.hideRePassword.value
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () =>
                                          controller.toggleRePassword(),
                                      color: ThemeService().isDarkMode
                                          ? Colors.white.withOpacity(0.4)
                                          : Colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Obx(
                                () => GosutoCheckbox(
                                  label: 'confirm_text'.tr,
                                  isChecked: controller.agreed.value,
                                  onChanged: (value) =>
                                      controller.toggleAgreed(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: <Widget>[
                                GosutoButton(
                                  text: 'continue'.tr,
                                  style: GosutoButtonStyle.fill,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GosutoButton(
                                  text: 'back'.tr,
                                  style: GosutoButtonStyle.text,
                                  onPress: () {
                                    Get.offAllNamed('/add_wallet');
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
