import 'package:casper_dart_sdk/casper_dart_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:gosuto/models/models.dart';
import 'package:gosuto/utils/utils.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem(
      {Key? key,
      required this.deploy,
      required this.wallet,
      this.subTitle = ''})
      : super(key: key);

  final String subTitle;
  final DeployModel deploy;
  final WalletModel wallet;

  @override
  Widget build(BuildContext context) {
    var deployName = '';
    var publicKey = wallet.publicKey.toLowerCase();
    var historyItemStyle = 0;

    var amount = deploy.executionTypeId != 2
        ? double.parse(CasperClient.fromWei(deploy.amount.toString()))
        : 0.0;

    switch (deploy.executionTypeId) {
      case 1:
        // WASM Deploy
        historyItemStyle = 1;
        deployName = 'wasm'.tr;
        break;
      case 2:
        // Contract interaction
        deployName = 'contract_interaction'.tr;

        if (deploy.entryPoint?.name == 'delegate' ||
            deploy.entryPoint?.name == 'undelegate') {
          historyItemStyle = 3;
          amount = double.parse(CasperClient.fromWei(deploy.amount.toString()));
        }
        break;
      case 6:
      default:
        // Transfer
        deployName = 'transfer'.tr;

        if (deploy.callerPublicKey.toLowerCase() == publicKey) {
          historyItemStyle = 3;
          deployName = 'sent'.tr;
        }
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      deployName,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(fontSize: 12),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      subTitle,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(fontSize: 10),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  GetTimeAgo.parse(DateTime.parse(deploy.timestamp).toLocal(),
                      pattern: 'LLL d, hh:mm:ss a'),
                  overflow: TextOverflow.clip,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontSize: 11, fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
          if (historyItemStyle == 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('-',
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color:
                            Theme.of(context).colorScheme.tertiaryContainer)),
              ],
            ),
          if (historyItemStyle == 1 || historyItemStyle == 3)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('-${NumberUtils.format(amount)} CSPR',
                    style: Theme.of(context).textTheme.headline5),
                const SizedBox(height: 5),
                Text(
                  NumberUtils.formatCurrency(amount * (deploy.rate ?? 0)),
                  style: Theme.of(context).textTheme.headline5,
                )
              ],
            ),
          // if (index == 3)
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: SvgPicture.asset(
          //     'assets/svgs/ic-swap-3.svg',
          //     color: Theme.of(context).colorScheme.tertiaryContainer,
          //     width: 23,
          //   ),
          // ),
          if (historyItemStyle == 4)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '+${NumberUtils.format(amount)} CSPR',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(fontSize: 13),
                ),
                const SizedBox(height: 5),
                Text(
                  NumberUtils.formatCurrency(amount * (deploy.rate ?? 0)),
                  style: Theme.of(context).textTheme.headline3,
                )
              ],
            ),
        ],
      ),
    );
  }
}
