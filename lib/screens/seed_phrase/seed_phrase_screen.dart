import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gosuto/components/text_chip.dart';
import '../../components/button.dart';
import '../../utils/constants.dart';
import 'seed_phrase_controller.dart';

class SeedPhraseScreen extends GetView<SeedPhraseController> {
  const SeedPhraseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'seed_phrase_text1'.tr,
                          style: AppConstants.subTextStyle,
                        ),
                        Text(
                          'seed_phrase_text2'.tr,
                          style: AppConstants.subTextStyle,
                        ),
                        Text(
                          'seed_phrase_text3'.tr,
                          style: AppConstants.subTextStyle,
                        ),
                        Text(
                          'seed_phrase_text4'.tr,
                          style: AppConstants.subTextStyle,
                        ),
                        Text(
                          'seed_phrase_text5'.tr,
                          style: AppConstants.subTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 20,
                        runSpacing: 20,
                        children: const [
                          GosutoTextChip(index: '1', text: 'Test'),
                          GosutoTextChip(index: '2', text: 'TestTest'),
                          GosutoTextChip(
                            index: '3',
                            text: 'TestTest',
                            isEditable: true,
                          ),
                          GosutoTextChip(index: '4', text: 'Test'),
                          GosutoTextChip(index: '5', text: 'TestTest'),
                          GosutoTextChip(
                            index: '6',
                            text: 'TestTest',
                            isEditable: true,
                          ),
                          GosutoTextChip(index: '7', text: 'Test'),
                          GosutoTextChip(index: '8', text: 'TestTest'),
                          GosutoTextChip(index: '9', text: 'TestTest'),
                          GosutoTextChip(index: '10', text: 'Test'),
                          GosutoTextChip(index: '11', text: 'TestTest'),
                          GosutoTextChip(index: '12', text: 'TestTest'),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      GosutoButton(
                        text: 'continue'.tr,
                        style: GosutoButtonStyle.fill,
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
