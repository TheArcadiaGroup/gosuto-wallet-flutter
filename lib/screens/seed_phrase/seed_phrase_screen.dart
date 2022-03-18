import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gosuto/components/text_chip.dart';
import 'package:gosuto/services/service.dart';
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

  void _copyToClipboard() {
    Clipboard.setData(
      ClipboardData(text: controller.seedPhrase.value),
    );
    controller.copied.value = true;
  }

  void _onContinue(context, yyDialog) async {
    if (!controller.copied.value) {
      YYDialog.init(context);
      yyDialog = YYDialog().build(context)
        ..barrierColor = Colors.black.withOpacity(0.6)
        ..borderRadius = 34
        ..width = getProportionateScreenWidth(372)
        ..widget(
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(60),
              vertical: 30,
            ),
            child: Column(
              children: [
                Text(
                  'did_not_copy_seed_phrase'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF121826),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                GosutoButton(
                  text: 'Confirm',
                  style: GosutoButtonStyle.fill,
                  onPressed: () {
                    yyDialog?.dismiss();
                  },
                )
              ],
            ),
          ),
        )
        ..show();
    }
  }

  @override
  Widget build(BuildContext context) {
    YYDialog? yyDialog;
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
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.resolveWith(
                              (states) => ThemeService().isDarkMode
                                  ? Colors.white.withOpacity(0.05)
                                  : Colors.black.withOpacity(0.05)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide.none,
                            ),
                          ),
                        ),
                        onPressed: _copyToClipboard,
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
                          _onContinue(context, yyDialog);
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
