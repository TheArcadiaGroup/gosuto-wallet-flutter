import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TransactionInfoCard extends StatelessWidget {
  const TransactionInfoCard({Key? key, this.subTitle = ''}) : super(key: key);

  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      // height: 435,
      padding: const EdgeInsets.all(25),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 400,
            child: Text(
              'received'.tr,
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
                  width: 42,
                  child: Text(
                    'to'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontSize: 14),
                  ),
                ),
                Text(
                  '0x9f98e01d2...4ed7',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
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
                    width: 42,
                    child: Text(
                      'from'.tr,
                      style: Theme.of(context).textTheme.subtitle1,
                    )),
                Text(
                  '0x9f98e01d2...4ed7',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Theme.of(context).colorScheme.tertiaryContainer),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'transaction_date'.tr,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  'Apr 01, 2021 07:15:20 am (EST)',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
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
                style: Theme.of(context).textTheme.headline4,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '-50 CSPR'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontSize: 13),
                  ),
                  Text(
                    '0.00 USD',
                    style: Theme.of(context).textTheme.headline5,
                  )
                ],
              ),
              SvgPicture.asset(
                'assets/svgs/ic-swap-3.svg',
                color: Theme.of(context).colorScheme.tertiaryContainer,
                width: 23,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '+50 CSPR'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(fontSize: 13),
                  ),
                  Text(
                    '0.00 USD',
                    style: Theme.of(context).textTheme.headline3,
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Divider(
              height: 1,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          Row(
            children: [
              Text(
                'transaction_fee'.tr,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '2.5%',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Theme.of(context).colorScheme.tertiaryContainer),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'transaction_hash'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '0x9f98e01d2...4ed7 ',
                  style: Theme.of(context).textTheme.headline4,
                )
              ],
            ),
          ),
          Container(
            width: 400,
            padding: const EdgeInsets.only(top: 15),
            child: ElevatedButton(
              onPressed: () => {},
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                  foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.background)),
              // label: Text('choose_file'.tr),
              // icon: Image.asset('assets/images/ic-choose-file.png'),
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
