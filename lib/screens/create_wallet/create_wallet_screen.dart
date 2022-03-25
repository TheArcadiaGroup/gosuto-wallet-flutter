import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gosuto/services/service.dart';
import 'package:gosuto/utils/utils.dart';

import '../../components/button.dart';
import '../../components/checkbox.dart';
import '../../components/dialog.dart';
import '../../utils/size_config.dart';
import 'create_wallet_controller.dart';

class CreateWalletScreen extends GetView<CreateWalletController> {
  const CreateWalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

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
                  'create_a_new_wallet'.tr,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(25),
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                    key: controller.formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              SizedBox(
                                height: getProportionateScreenHeight(30),
                              ),
                              TextFormField(
                                controller: controller.walletNameController,
                                cursorColor:
                                    Theme.of(context).colorScheme.onSurface,
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
                              Obx(
                                () => TextFormField(
                                  // obscureText: controller.hidePassword.value,
                                  controller: controller.passwordController,
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
                                  onChanged: (value) {
                                    controller.password.value = value;
                                  },
                                  onSaved: (value) {
                                    controller.password.value = value!;
                                  },
                                  validator: (value) {
                                    return controller.validatePassword(value!);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(30),
                              ),
                              Obx(
                                () => TextFormField(
                                  // obscureText: controller.hideRePassword.value,
                                  controller: controller.password2Controller,
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
                                  onChanged: (value) {
                                    controller.password2.value = value;
                                  },
                                  onSaved: (value) {
                                    controller.password2.value = value!;
                                  },
                                  validator: (value) {
                                    return controller
                                        .validateConfirmPassword(value!);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(20),
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
                          child: Column(
                            children: [
                              Obx(
                                () => GosutoButton(
                                  text: 'continue'.tr,
                                  style: GosutoButtonStyle.fill,
                                  disabled: !controller.agreed.value,
                                  onPressed: () async {
                                    bool isValid =
                                        await controller.checkValidate();
                                    print('walletName.value: ' +
                                        controller.walletName.value);
                                    print('password.value: ' +
                                        controller.password.value);

                                    if (isValid && controller.agreed.value) {
                                      controller.formKey.currentState?.save();
                                      Get.toNamed('/seed_phrase', arguments: [
                                        {
                                          'walletName':
                                              controller.walletName.value
                                        },
                                        {'password': controller.password.value},
                                      ]);
                                    } else {
                                      GosutoDialog().buildDialog(context, [
                                        Text(
                                          'wallet_name_exist'.tr,
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
                                          height:
                                              getProportionateScreenHeight(30),
                                        ),
                                        GosutoButton(
                                          text: 'confirm'.tr,
                                          style: GosutoButtonStyle.fill,
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                          },
                                        )
                                      ]);
                                    }
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
                              )
                            ],
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
