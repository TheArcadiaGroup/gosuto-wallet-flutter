import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:gosuto/themes/colors.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  Widget _buildWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(left: 24),
      // height: 214,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppDarkColors.tabBarIndicatorColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/default-avatar.png',
                          width: 36, height: 36),
                      const SizedBox(width: 5),
                      Expanded(
                          child: Text('Wallet 1',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('available'.tr.toUpperCase()),
                  RichText(
                      text: TextSpan(
                          text: '250.510 CSPR ≈ ',
                          style: Theme.of(context).textTheme.bodyText1,
                          children: [
                        TextSpan(
                            text: '\$2,500 USD',
                            style: Theme.of(context).textTheme.subtitle2)
                      ])),
                  const SizedBox(height: 20),
                  Text('stacked'.tr.toUpperCase()),
                  RichText(
                      text: TextSpan(
                          text: '250.510 CSPR ≈ ',
                          style: Theme.of(context).textTheme.bodyText1,
                          children: [
                        TextSpan(
                            text: '\$2,500 USD',
                            style: Theme.of(context).textTheme.subtitle2)
                      ])),
                  const SizedBox(height: 10),
                  RichText(
                      text: TextSpan(
                          text: 'unclaimed_rewards'.tr,
                          style: Theme.of(context).textTheme.subtitle2,
                          children: [
                        TextSpan(
                            text: ' \$375 USD',
                            style: Theme.of(context).textTheme.bodyText1)
                      ]))
                ],
              ),
            ),
          ),
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Image.asset('assets/images/triangle.png'),
              Container(
                width: 120,
                padding: const EdgeInsets.only(top: 23, bottom: 23, right: 20),
                child: Image.asset('assets/images/image-card.png',
                    width: 101, height: 163),
              ),
            ],
          )
        ],
      ),
    );
  }
}
