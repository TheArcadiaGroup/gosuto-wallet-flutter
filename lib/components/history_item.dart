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
      required this.transfer,
      required this.wallet,
      this.subTitle = ''})
      : super(key: key);

  final String subTitle;
  final TransferModel transfer;
  final WalletModel wallet;

  @override
  Widget build(BuildContext context) {
    var deployName = '';

    if (wallet.publicKey.toLowerCase() ==
        transfer.fromAccountPublicKey.toLowerCase()) {
      if (transfer.toAccountPublicKey == null) {
        deployName = 'contract_interaction'.tr;
      } else {
        deployName = 'sent'.tr;
      }
    } else {
      deployName = 'received'.tr;
    }

    final index = wallet.publicKey == transfer.fromAccountPublicKey ? 4 : 1;

    final amount =
        CasperClient.fromWei(BigNumber.from(transfer.amount)).toDouble();

    return Padding(
      padding: const EdgeInsets.all(15),
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
                  GetTimeAgo.parse(DateTime.parse(transfer.timestamp).toLocal(),
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
          (index == 1
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '-${NumberUtils.format(amount)} CSPR',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(fontSize: 13),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      NumberUtils.formatCurrency(transfer.currencyAmount),
                      style: Theme.of(context).textTheme.headline5,
                    )
                  ],
                )),
          if (index == 3)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/svgs/ic-swap-3.svg',
                color: Theme.of(context).colorScheme.tertiaryContainer,
                width: 23,
              ),
            ),
          if (index == 1 || index == 3)
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
                  NumberUtils.formatCurrency(transfer.currencyAmount),
                  style: Theme.of(context).textTheme.headline3,
                )
              ],
            ),
        ],
      ),
    );
  }
}
