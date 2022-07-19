import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gosuto/models/models.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem(
      {Key? key,
      required this.transfer,
      required this.wallet,
      required this.rate,
      this.subTitle = ''})
      : super(key: key);

  final String subTitle;
  final TransferModel transfer;
  final WalletModel wallet;
  final double rate;

  @override
  Widget build(BuildContext context) {
    final index = wallet.publicKey == transfer.fromAccountPublicKey ? 4 : 1;

    final amount = double.parse(transfer.amount) / 1e9;

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
                      index == 1
                          ? 'received'.tr
                          : (index == 2
                              ? 'stake'.tr
                              : (index == 3 ? 'swap'.tr : 'sent'.tr)),
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
                  transfer.timestamp,
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
                      '-$amount CSPR'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(fontSize: 13),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${(amount * rate).toStringAsFixed(2)} USD',
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
                  '+$amount CSPR'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(fontSize: 13),
                ),
                const SizedBox(height: 5),
                Text(
                  '${(amount * rate).toStringAsFixed(2)} USD',
                  style: Theme.of(context).textTheme.headline3,
                )
              ],
            ),
        ],
      ),
    );
  }
}
