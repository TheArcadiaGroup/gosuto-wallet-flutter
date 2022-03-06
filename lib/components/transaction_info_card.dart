import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TransactionInfoCard extends StatelessWidget {
  const TransactionInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 435,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Theme.of(context).colorScheme.secondary)),
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
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Row(
              children: [
                SizedBox(
                    width: 42,
                    child: Text(
                      'to'.tr,
                      style: Theme.of(context).textTheme.subtitle1,
                    )),
                Text(
                  '0x9f98e01d2...4ed7',
                  style: Theme.of(context).textTheme.headline4,
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
                  style: Theme.of(context).textTheme.headline4,
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
                  style: Theme.of(context).textTheme.headline4,
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
                        ?.copyWith(fontSize: 14),
                  ),
                  Text(
                    '0.00 USD',
                    style: Theme.of(context).textTheme.headline5,
                  )
                ],
              ),
              SvgPicture.asset('assets/svgs/ic-swap-3.svg'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '+50 CSPR'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(fontSize: 14),
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
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '2.5%',
                  style: Theme.of(context).textTheme.headline4,
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
                  style: Theme.of(context).textTheme.subtitle1,
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
              child: Text('view_on_block_explorer'.tr),
            ),
          ),
        ],
      ),
    );
  }
}
