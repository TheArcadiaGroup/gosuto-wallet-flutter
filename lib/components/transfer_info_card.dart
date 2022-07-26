import 'package:casper_dart_sdk/classes/classes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:gosuto/env/env.dart';
import 'package:gosuto/utils/utils.dart';

import '../models/models.dart';

class TransferInfoCard extends StatelessWidget {
  const TransferInfoCard({
    Key? key,
    this.deploy,
    required this.wallet,
    this.subTitle = '',
  }) : super(key: key);

  final String subTitle;

  final DeployModel? deploy;
  final WalletModel wallet;

  @override
  Widget build(BuildContext context) {
    var deployName = '';
    var actionName = 'Transfer';
    var toAddress = '';
    var amount = 0.0;
    var cost = 0.0;

    if (deploy != null) {
      amount =
          CasperClient.fromWei(BigNumber.from(deploy?.amount ?? 0)).toDouble();

      cost = CasperClient.fromWei(BigNumber.from(deploy?.cost ?? 0)).toDouble();

      var args = deploy?.args as Map;

      if (deploy?.executionTypeId == 1) {
        deployName = 'contract_interaction'.tr;
        // Swap
        if (args['contract_hash_key'] != null) {
          toAddress = args['contract_hash_key']['parsed']['Hash']
              .toString()
              .replaceAll('hash-', '');
        }

        if (args['contract_hash_key'] != null) {
          actionName = args['deposit_entry_point_name']['parsed'];
        } else {
          actionName = 'swap'.tr;
        }
      } else if (deploy?.executionTypeId == 2) {
        // Contract interaction
        deployName = 'contract_interaction'.tr;
        toAddress = deploy?.contractHash ?? '';

        if (deploy?.entryPoint != null) {
          actionName = deploy?.entryPoint?.name ?? '';
        }
      } else if (deploy?.executionTypeId == 6) {
        deployName =
            deploy?.callerPublicKey.toLowerCase() == wallet.publicKey.toString()
                ? 'sent'.tr
                : 'received'.tr;
        // Transfers
        if (args['targetAccountHex'] != null) {
          toAddress = args['targetAccountHex']['parsed'];
        } else if (args['target'] != null) {
          toAddress = args['target']['parsed'];
        }
      }
      if (actionName.contains('swap')) {
        deployName = 'swap'.tr;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, -1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 400,
            child: Text(
              deployName,
              style:
                  Theme.of(context).textTheme.headline1?.copyWith(fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 400,
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Row(
              children: [
                SizedBox(
                  width: 90,
                  child: Text(
                    'to'.tr,
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.color
                            ?.withAlpha(170)),
                  ),
                ),
                Text(
                  Strings.displayHash(toAddress),
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.tertiaryContainer),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              children: [
                SizedBox(
                  width: 90,
                  child: Text(
                    'from'.tr,
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.color
                            ?.withAlpha(170)),
                  ),
                ),
                Text(
                  Strings.displayHash(deploy?.callerPublicKey ?? ''),
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.tertiaryContainer),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              children: [
                SizedBox(
                  width: 90,
                  child: Text(
                    'timestamp'.tr,
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.color
                            ?.withAlpha(170)),
                  ),
                ),
                Text(
                  GetTimeAgo.parse(
                      DateTime.parse(deploy?.timestamp ??
                              DateTime.now().toIso8601String())
                          .toLocal(),
                      pattern: 'LLL d, hh:mm:ss a'),
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.tertiaryContainer),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              children: [
                SizedBox(
                  width: 90,
                  child: Text(
                    'action'.tr,
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.color
                            ?.withAlpha(170)),
                  ),
                ),
                Text(
                  actionName,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.tertiaryContainer),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Divider(
              height: 1,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'amount'.tr,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.color
                        ?.withAlpha(170)),
              ),
              (deploy?.callerPublicKey.toLowerCase() ==
                      wallet.publicKey.toString()
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '-${NumberUtils.format(amount)} CSPR',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(fontSize: 13),
                            ),
                            Text(
                              NumberUtils.formatCurrency(
                                  deploy?.currencyCost ?? 0),
                              style: Theme.of(context).textTheme.headline5,
                            )
                          ],
                        ),
                      ],
                    )
                  : (Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
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
                            Text(
                              NumberUtils.formatCurrency(
                                  deploy?.currencyCost ?? 0),
                              style: Theme.of(context).textTheme.headline3,
                            )
                          ],
                        ),
                      ],
                    )))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Divider(
              height: 1,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              children: [
                SizedBox(
                  width: 90,
                  child: Text(
                    'cost'.tr,
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.color
                            ?.withAlpha(170)),
                  ),
                ),
                Text(
                  '${NumberUtils.format(cost, 5)} CSPR',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.tertiaryContainer),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              children: [
                SizedBox(
                  width: 90,
                  child: Text(
                    'deploy_hash'.tr,
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.color
                            ?.withAlpha(170)),
                  ),
                ),
                Text(
                  Strings.displayHash(deploy?.deployHash ?? ''),
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.tertiaryContainer),
                ),
              ],
            ),
          ),
          Container(
            width: 400,
            padding: const EdgeInsets.only(top: 15),
            child: ElevatedButton(
              onPressed: () => {
                Urls.launchInWebViewOrVC(Uri.parse(
                    '${env?.deployHashExplorer ?? ''}${deploy?.deployHash}'))
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                  foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.background)),
              child: Text(
                'view_on_block_explorer'.tr,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
