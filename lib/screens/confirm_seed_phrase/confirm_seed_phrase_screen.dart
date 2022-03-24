import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gosuto/components/dialog.dart';
import 'package:gosuto/components/text_chip.dart';
import '../../components/button.dart';
import '../../services/theme_service.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import 'confirm_seed_phrase_controller.dart';

class ConfirmSeedPhraseScreen extends GetView<ConfirmSeedPhraseController> {
  const ConfirmSeedPhraseScreen({Key? key}) : super(key: key);

  List<Widget> _generateTextChips() {
    final words = controller.seedPhrase.value.split(' ');
    List<Widget> textChips = [];

    if (words.length == 12) {
      textChips = List.generate(12, (index) {
        bool isEditable = false;

        if (index == controller.listOfIndexes[0] ||
            index == controller.listOfIndexes[1] ||
            index == controller.listOfIndexes[2]) {
          isEditable = true;
        }

        return GosutoTextChip(
          index: (index + 1).toString(),
          text: words[index],
          isEditable: isEditable,
          onChanged: (String text) {
            _onMissingWordChanged(text, index);
          },
        );
      }, growable: false);
    }

    return textChips;
  }

  void _onMissingWordChanged(String text, int index) {
    if (index == controller.listOfIndexes[0]) {
      controller.word1.value = text;
    }
    if (index == controller.listOfIndexes[1]) {
      controller.word2.value = text;
    }
    if (index == controller.listOfIndexes[2]) {
      controller.word3.value = text;
    }
  }

  Future<void> _onContinue(context) async {
    List<String> words = controller.getListOfWords();
    controller.seedPhraseToCompare.value = words.join(' ');

    if (controller.seedPhraseToCompare.value == controller.seedPhrase.value) {
      int walletId = await controller.generateWallet();

      if (walletId > 0) {
        print(walletId);
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
          'invalid_seed_phrase'.tr,
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
                          'retype_seed_phrase_text1'.tr,
                          style: AppConstants.subTextStyle,
                        ),
                        Text(
                          'retype_seed_phrase_text2'.tr,
                          style: AppConstants.subTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(35),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: getProportionateScreenWidth(16),
                        runSpacing: getProportionateScreenHeight(16),
                        children: _generateTextChips(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Obx(
                        () => GosutoButton(
                          text: 'continue'.tr,
                          style: GosutoButtonStyle.fill,
                          disabled: controller.word1.value.isEmpty ||
                              controller.word2.value.isEmpty ||
                              controller.word3.value.isEmpty,
                          onPressed: () {
                            _onContinue(context);
                          },
                        ),
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
