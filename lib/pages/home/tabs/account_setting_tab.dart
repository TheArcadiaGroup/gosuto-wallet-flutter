import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:gosuto/pages/home/home.dart';
import 'package:gosuto/services/service.dart';
import 'package:gosuto/themes/colors.dart';
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
  }

  Widget _buildWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 27, bottom: 27),
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
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                      foregroundColor:
                          MaterialStateProperty.all(AppDarkColors.orangeColor),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          color: AppDarkColors.orangeColor, fontSize: 16))),
                  label: Text('choose_file'.tr),
                  icon: Image.asset(
                    'assets/images/ic-choose-file.png',
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 70, right: 70, bottom: 20),
                child: Column(
                  children: [
                    _buildTextField(context, 'name'.tr),
                    Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                            onPressed: () => {},
                            child: Text('change_name'.tr,
                                style: const TextStyle(
                                    color: AppDarkColors.orangeColor)))),
                    _buildTextField(context, 'email'.tr),
                    Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                            onPressed: () => {},
                            child: Text('change_name'.tr,
                                style: const TextStyle(
                                    color: AppDarkColors.orangeColor)))),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                width: 296,
                height: 77,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'change_theme'.tr,
                      style: Theme.of(context).textTheme.bodyText1,
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
                          style: Theme.of(context).textTheme.subtitle1,
                          items: _buildDropDownMenuLanguageItems(),
                          onChanged: _changeLanguage,
                        ),
                      )),
                  Obx(() => DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: controller.selectedCoin.value,
                          dropdownColor: Theme.of(context).colorScheme.primary,
                          style: Theme.of(context).textTheme.subtitle1,
                          items: _buildDropDownMenuCoinItems(),
                          onChanged: _changeCoin,
                        ),
                      ))
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 51,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('save'.tr),
                      style: ElevatedButton.styleFrom(
                        primary: AppDarkColors.orangeColor,
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
                      child: Text('cancel'.tr,
                          style: const TextStyle(
                              color: AppDarkColors.orangeColor)),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.primary,
                        side: const BorderSide(
                            width: 1.0, color: AppDarkColors.orangeColor),
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

  Widget _buildTextField(BuildContext context, String label) {
    return TextField(
      cursorColor: Theme.of(context).colorScheme.onSurface,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onSecondary, width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(18.0))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onSecondary, width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(18.0))),
          contentPadding: const EdgeInsets.only(left: 20, right: 20),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18.0))),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: label,
          labelStyle: Theme.of(context).textTheme.bodyText1,
          hintText: label,
          hintStyle: Theme.of(context).textTheme.bodyText2),
    );
  }

  List<DropdownMenuItem<String>> _buildDropDownMenuLanguageItems() {
    // var list = <DropdownMenuItem<String>>[];
    // TranslationService.langs.forEach((key, value) {
    //   list.add(DropdownMenuItem(value: key, child: Text(key)));
    // });
    // return list;
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
