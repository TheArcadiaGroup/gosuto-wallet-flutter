import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({Key? key, required this.index, this.subTitle = ''})
      : super(key: key);

  final int index;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
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
                  'Apr 01, 2021 07:15:20 am (CST)',
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
                      '-50 CSPR'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(fontSize: 13),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '0.00 USD',
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
                  '+50 CSPR'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(fontSize: 13),
                ),
                const SizedBox(height: 5),
                Text(
                  '0.00 USD',
                  style: Theme.of(context).textTheme.headline3,
                )
              ],
            ),
        ],
      ),
    );

    // return Padding(
    //   padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
    //   child: Column(
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 index == 1
    //                     ? 'received'.tr
    //                     : (index == 2
    //                         ? 'stake'.tr
    //                         : (index == 3 ? 'swap'.tr : 'sent'.tr)),
    //                 style: Theme.of(context).textTheme.headline4,
    //               ),
    //               Text(
    //                 'Apr 01, 2021 07:15:20 am (CST)',
    //                 style: Theme.of(context).textTheme.subtitle1,
    //               )
    //             ],
    //           ),
    //           (index == 1
    //               ? Container()
    //               : Column(
    //                   crossAxisAlignment: CrossAxisAlignment.end,
    //                   children: [
    //                     Text(
    //                       '-50 CSPR'.tr,
    //                       style: Theme.of(context)
    //                           .textTheme
    //                           .headline5
    //                           ?.copyWith(fontSize: 14),
    //                     ),
    //                     Text(
    //                       '0.00 USD',
    //                       style: Theme.of(context).textTheme.headline5,
    //                     )
    //                   ],
    //                 )),
    //           if (index == 3) SvgPicture.asset('assets/svgs/ic-swap-3.svg'),
    //           if (index == 1 || index == 3)
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.end,
    //               children: [
    //                 Text(
    //                   '+50 CSPR'.tr,
    //                   style: Theme.of(context)
    //                       .textTheme
    //                       .headline3
    //                       ?.copyWith(fontSize: 14),
    //                 ),
    //                 Text(
    //                   '0.00 USD',
    //                   style: Theme.of(context).textTheme.headline3,
    //                 )
    //               ],
    //             ),
    //         ],
    //       ),
    //       const SizedBox(height: 20),
    //       Divider(
    //         height: 1,
    //         color: Theme.of(context).colorScheme.onSecondary,
    //       ),
    //     ],
    //   ),
    // );
  }
}
