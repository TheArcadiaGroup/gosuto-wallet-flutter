import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:gosuto/components/components.dart';
import 'package:gosuto/screens/home/home.dart';
import 'package:gosuto/services/service.dart';
import 'package:gosuto/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class AccountSettingTab extends GetView<HomeController> {
  AccountSettingTab({Key? key}) : super(key: key);
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  void _pickPhotoAlbum() {
    runZonedGuarded(() async {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) {
        return;
      }
      controller.avatarPath(pickedFile.path);
    }, (err, stack) {});
  }

  void _pickCamera() {
    runZonedGuarded(() async {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile == null) {
        return;
      }
      controller.avatarPath(pickedFile.path);
    }, (err, stack) {});
  }

  void _switchMode(value) {
    controller.isDarkMode(value);
    ThemeService().switchTheme(value);
  }

  void _changeLanguage(value) {
    controller.selectedLanguage(value);
    TranslationService().changeLocale(value);
  }

  void _changeCoin(value) {
    controller.selectedCoin(value);
    CoinService().switchCoin(value);
  }

  Widget _buildWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 27, bottom: 60),
        child: Center(
          child: Column(
            children: [
              Text(
                'account_setting'.tr,
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(height: 20),
              Obx(() => Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      controller.avatarPath.value != ""
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.file(
                                  File(controller.avatarPath.value),
                                  width: 146,
                                  height: 140,
                                  fit: BoxFit.fill),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                  'assets/images/dark/default-avatar.png'),
                            ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(25)),
                        width: 146,
                        height: 140,
                      ),
                      IconButton(
                          onPressed: _pickCamera,
                          icon: Image.asset(
                            'assets/images/ic-camera.png',
                          )),
                    ],
                  )),
              ElevatedButton.icon(
                  onPressed: _pickPhotoAlbum,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                    foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.background,
                    ),
                    textStyle: MaterialStateProperty.all(
                      TextStyle(
                        color: Theme.of(context).colorScheme.background,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  label: Text('choose_file'.tr),
                  icon: Image.asset(
                    'assets/images/ic-choose-file.png',
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 70, right: 70, bottom: 20),
                child: Column(
                  children: [
                    // _buildTextField(context, 'name'.tr),
                    CustomWidgets.textField(context, 'name'.tr,
                        onChanged: (text) => {}),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () => {},
                        child: Text(
                          'change_name'.tr,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                      ),
                    ),
                    // _buildTextField(context, 'email'.tr),
                    CustomWidgets.textField(context, 'email'.tr,
                        onChanged: (text) => {}),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () => {},
                        child: Text(
                          'change_name'.tr,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.secondary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(12),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, -1), // changes position of shadow
                    ),
                  ],
                ),
                width: 296,
                height: 77,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'change_theme'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(fontSize: 13),
                    ),
                    Obx(
                      () => FlutterSwitch(
                          width: 42,
                          height: 25,
                          toggleSize: 18,
                          value: controller.isDarkMode.value,
                          borderRadius: 44.0,
                          padding: 1,
                          activeToggleColor: Colors.black,
                          inactiveToggleColor: Colors.white,
                          activeColor: Colors.white10,
                          inactiveColor: const Color(0xFFF7F7F7),
                          activeIcon:
                              Image.asset('assets/images/ic-dark-mode.png'),
                          inactiveIcon:
                              Image.asset('assets/images/ic-light-mode.png'),
                          onToggle: _switchMode),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(() => DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: controller.selectedLanguage.value,
                          dropdownColor: Theme.of(context).colorScheme.primary,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(fontSize: 12),
                          items: _buildDropDownMenuLanguageItems(),
                          onChanged: _changeLanguage,
                        ),
                      )),
                  Obx(() => DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: controller.selectedCoin.value,
                          dropdownColor: Theme.of(context).colorScheme.primary,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(fontSize: 12),
                          items: _buildDropDownMenuCoinItems(),
                          onChanged: _changeCoin,
                        ),
                      ))
                ],
              ),
              const SizedBox(height: 67),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 51,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'save'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            ?.copyWith(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 51,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'cancel'.tr,
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.primary,
                        side: BorderSide(
                            width: 1.0,
                            color: Theme.of(context).colorScheme.background),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDropDownMenuLanguageItems() {
    return TranslationService.langCodes.map((String items) {
      return DropdownMenuItem(
        value: items,
        child: Text(items.toUpperCase()),
      );
    }).toList();
  }

  List<DropdownMenuItem<String>> _buildDropDownMenuCoinItems() {
    return AppConstants.coins.map((String items) {
      return DropdownMenuItem(
        value: items,
        child: Text(items),
      );
    }).toList();
  }
}
