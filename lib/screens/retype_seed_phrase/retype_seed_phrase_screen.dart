import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gosuto/components/text_chip.dart';
import '../../components/button.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import 'retype_seed_phrase_controller.dart';

class RetypeSeedPhraseScreen extends GetView<RetypeSeedPhraseController> {
  const RetypeSeedPhraseScreen({Key? key}) : super(key: key);

  List<Widget> _generateTextChips() {
    final words = controller.seedPhrase.value.split(' ');
    List<Widget> textChips = [];
    Random random = Random();
    Set<int> setOfIndexes = {};

    while (setOfIndexes.length < 3) {
      setOfIndexes.add(random.nextInt(12));
    }
    print(setOfIndexes.length);

    if (words.length == 12) {
      textChips = List.generate(12, (index) {
        bool isEditable = false;

        if (index == setOfIndexes.elementAt(0) ||
            index == setOfIndexes.elementAt(1) ||
            index == setOfIndexes.elementAt(2)) {
          isEditable = true;
        }
        return GosutoTextChip(
          index: index.toString(),
          text: words[index],
          isEditable: isEditable,
        );
      }, growable: false);
    }

    return textChips;
  }

  void _onContinue(context) {}

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
                      GosutoButton(
                        text: 'continue'.tr,
                        style: GosutoButtonStyle.fill,
                        onPressed: () {
                          _onContinue(context);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
