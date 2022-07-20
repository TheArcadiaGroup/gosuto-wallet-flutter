import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:gosuto/models/models.dart';
import 'package:gosuto/themes/colors.dart';
import 'package:gosuto/utils/account.dart';
import 'package:gosuto/utils/number.dart';

class WalletCard extends StatefulWidget {
  const WalletCard({Key? key, required this.wallet, required this.rate})
      : super(key: key);

  final WalletModel wallet;
  final double rate;

  @override
  State<StatefulWidget> createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard> {
  late Future<double> futureBalance;
  late Future<double> futureTotalStake;
  late Future<double> futureTotalRewards;

  @override
  void initState() {
    super.initState();
    futureBalance = AccountUtils.fetchBalance(widget.wallet.publicKey);
    futureTotalStake = AccountUtils.getTotalStake(widget.wallet.publicKey);
    futureTotalRewards = AccountUtils.getTotalRewards(
        widget.wallet.publicKey, widget.wallet.isValidator);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(left: 24),
      // height: 214,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.borderWalletCard1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, -1), // changes position of shadow
          ),
        ],
      ),
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
                          child: Text(widget.wallet.name,
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'available'.tr.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  FutureBuilder(
                      future: futureBalance,
                      builder: (context, snapshot) {
                        var textCSPR = '-- CSPR ~ ';
                        var textUSD = '\$--';
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          var balance = double.parse(snapshot.data.toString());
                          var usdValue = balance * widget.rate;
                          textCSPR = '${NumberUtils.format(balance)} CSPR ~ ';
                          textUSD = NumberUtils.formatCurrency(usdValue);
                        }
                        return RichText(
                            text: TextSpan(
                                text: textCSPR,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                children: [
                              TextSpan(
                                text: textUSD,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              )
                            ]));
                      }),
                  const SizedBox(height: 10),
                  Divider(
                    height: 1,
                    color: Colors.black.withOpacity(0.1),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'staked'.tr.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  FutureBuilder(
                      future: futureTotalStake,
                      builder: (context, snapshot) {
                        var textCSPR = '-- CSPR ~ ';
                        var textUSD = '\$--';
                        if (snapshot.hasData) {
                          var balance = double.parse(snapshot.data.toString());
                          var usdValue = balance * widget.rate;
                          textCSPR = '${NumberUtils.format(balance)} CSPR ~ ';
                          textUSD = NumberUtils.formatCurrency(usdValue);
                        }
                        return RichText(
                            text: TextSpan(
                                text: textCSPR,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                children: [
                              TextSpan(
                                text: textUSD,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              )
                            ]));
                      }),
                  const SizedBox(height: 10),
                  FutureBuilder(
                    future: futureTotalRewards,
                    builder: (context, snapshot) {
                      var textCSPR = '-- CSPR ~ ';
                      var textUSD = '\$--';
                      if (snapshot.hasData) {
                        var totalRewards =
                            double.parse(snapshot.data.toString());
                        var usdValue = totalRewards * widget.rate;

                        textCSPR = '${NumberUtils.format(totalRewards)} CSPR';
                        textUSD = NumberUtils.formatCurrency(usdValue);
                      }

                      return RichText(
                          text: TextSpan(
                              text: 'total_rewards'.tr,
                              style: Theme.of(context).textTheme.subtitle2,
                              children: [
                            TextSpan(
                              text: '\n$textCSPR ($textUSD)',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 12),
                            )
                          ]));
                    },
                  ),
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
                    width: 100, height: 172),
              ),
            ],
          )
        ],
      ),
    );
  }
}
