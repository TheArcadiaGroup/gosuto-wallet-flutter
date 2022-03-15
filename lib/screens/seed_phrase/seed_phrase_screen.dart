import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gosuto/components/text_chip.dart';
import '../../components/button.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import 'seed_phrase_controller.dart';

class SeedPhraseScreen extends GetView<SeedPhraseController> {
  const SeedPhraseScreen({Key? key}) : super(key: key);

  List<Widget> _generateTextChips() {
    final words = controller.seedPhrase.value.split(' ');
    List<Widget> textChips = [];

    if (words.length == 12) {
      textChips = List.generate(12, (index) {
        return GosutoTextChip(index: index.toString(), text: words[index]);
      }, growable: false);
    }

    return textChips;
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
                      SizedBox(
                        height: getProportionateScreenHeight(30),
                      ),
                      TextButton.icon(
                        icon: Text(
                          'copy_to_clipboard'.tr,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFFF7A28),
                          ),
                        ),
                        label: SvgPicture.asset('assets/svgs/ic-copy-2.svg'),
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: controller.seedPhrase.value),
                          );
                        },
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
