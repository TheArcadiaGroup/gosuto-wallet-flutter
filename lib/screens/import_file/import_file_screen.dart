import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gosuto/components/button.dart';
import 'package:gosuto/components/checkbox.dart';
import 'package:gosuto/components/dialog.dart';
import 'package:gosuto/routes/app_pages.dart';
import 'package:gosuto/screens/import_file/import_file.dart';
import 'package:gosuto/services/service.dart';
import 'package:gosuto/themes/colors.dart';
import 'package:gosuto/utils/utils.dart';

class ImportFileScreen extends GetView<ImportFileController> {
  const ImportFileScreen({Key? key}) : super(key: key);

  Future<void> _onContinue(context) async {
    var obj = await controller.checkValidate();

    if (obj['isValid']) {
      controller.formKey.currentState?.save();

      // save wallet to db
      int walletId = await controller.createWallet();

      if (walletId > 0) {
        Get.toNamed(Routes.home);
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

  Future<void> onPickFile(context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt', 'json'],
      );

      if (result != null) {
        File file = File(result.files.single.path ?? '');
        controller.fileName.value = result.files.single.name;

        final content = await file.readAsString();

        if (result.files.single.extension == 'json') {
          try {
            var data = jsonDecode(content);
            if (data['privatekey'] != '') {
              controller.privateKey.value = data['privatekey'];
            }
          } catch (e) {
            GosutoDialog().buildDialog(
              context,
              [
                Text(
                  'import_invalid_json'.tr,
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
              ],
            );
            log('JSON DECODE ERROR', error: e);
          }
        } else {
          controller.privateKey.value = content;
        }
      }
    } catch (e) {
      log('PICK FILE ERROR', error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    Widget _buildForm(context) {
      InputDecoration _inputDecoration =
          AppConstants.getInputDecoration(context);

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
          height: getProportionateScreenHeight(20),
        ),
        Obx(
          () => TextButton.icon(
            onPressed: () => onPickFile(context),
            icon: SvgPicture.asset('assets/svgs/import.svg'),
            label: Text(
              controller.fileName.value != ''
                  ? controller.fileName.value
                  : 'upload_privatekey_file'.tr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                height: 1.1,
                color: AppDarkColors.orangeColor,
              ),
            ),
          ),
        ),
        // File picker here
        SizedBox(
          height: getProportionateScreenHeight(30),
        ),
      ];

      return Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.always,
          child: FutureBuilder<String>(
            future: controller.getPassword(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // add password fields
                if (snapshot.hasData &&
                    (snapshot.data == null || snapshot.data == '')) {
                  widgets.addAll([
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
                  ]);
                }

                // add checkbox
                widgets.add(Obx(
                  () => GosutoCheckbox(
                    label: 'confirm_text'.tr,
                    isChecked: controller.agreed.value,
                    onChanged: (value) => controller.toggleAgreed(),
                  ),
                ));
              }

              return Column(
                children: widgets,
              );
            },
          ));
    }

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
                  'import_from_file'.tr,
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
                        height: getProportionateScreenHeight(25),
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
