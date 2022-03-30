import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/button.dart';
import '../../components/dialog.dart';
import '../../services/theme_service.dart';
import '../../themes/colors.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import 'import_seed_controller.dart';

class ImportSeedScreen extends GetView<ImportSeedController> {
  const ImportSeedScreen({Key? key}) : super(key: key);

  Widget _buildForm(context) {
    InputDecoration _inputDecoration = AppConstants.getInputDecoration(context);

    return Form(
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
                SizedBox(
                  height: 5 * 30,
                  child: TextFormField(
                    maxLines: 5,
                    minLines: 5,
                    controller: controller.seedPhraseController,
                    cursorColor: Theme.of(context).colorScheme.onSurface,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: _inputDecoration.copyWith(
                        labelText: 'seed_phrase'.tr,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 22, right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  var clipboardData = await Clipboard.getData(
                                      Clipboard.kTextPlain);
                                  controller.seedPhrase.value =
                                      clipboardData!.text!;
                                  controller.seedPhraseController.text =
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
                      controller.seedPhrase.value = value;
                    },
                    onSaved: (value) {
                      controller.seedPhrase.value = value!;
                    },
                    validator: (value) {
                      return controller.validateSeedPhrase(value!);
                    },
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                Obx(
                  () => TextFormField(
                    obscureText: controller.hidePassword.value,
                    controller: controller.passwordController,
                    cursorColor: Theme.of(context).colorScheme.onSurface,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: _inputDecoration.copyWith(
                      labelText: 'wallet_paddword'.tr,
                      prefixIcon: IconButton(
                        icon: ThemeService().isDarkMode
                            ? SvgPicture.asset('assets/svgs/dark/ic-lock.svg')
                            : SvgPicture.asset('assets/svgs/light/ic-lock.svg'),
                        onPressed: null,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(controller.hidePassword.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () => controller.togglePassword(),
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
                    obscureText: controller.hideRePassword.value,
                    controller: controller.password2Controller,
                    cursorColor: Theme.of(context).colorScheme.onSurface,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: _inputDecoration.copyWith(
                      labelText: 'wallet_paddword2'.tr,
                      prefixIcon: IconButton(
                        icon: ThemeService().isDarkMode
                            ? SvgPicture.asset('assets/svgs/dark/ic-lock.svg')
                            : SvgPicture.asset('assets/svgs/light/ic-lock.svg'),
                        onPressed: null,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(controller.hideRePassword.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () => controller.toggleRePassword(),
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
                      return controller.validateConfirmPassword(value!);
                    },
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                GosutoButton(
                  text: 'continue'.tr,
                  style: GosutoButtonStyle.fill,
                  onPressed: () async {
                    bool isValid = await controller.checkValidate();

                    if (isValid) {
                      controller.formKey.currentState?.save();
                      print('done');
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
                  },
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
                          'import_seed_phrase'.tr,
                          style: AppConstants.subTextStyle,
                        ),
                        Text(
                          'import_seed_phrase_text1'.tr,
                          style: AppConstants.subTextStyle,
                        ),
                        Text(
                          'import_seed_phrase_text2'.tr,
                          style: AppConstants.subTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(child: _buildForm(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}