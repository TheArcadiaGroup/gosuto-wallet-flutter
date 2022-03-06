import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SliderItem extends StatelessWidget {
  const SliderItem(
      {Key? key,
      required this.width,
      required this.height,
      this.paddingHorizontal = 22,
      this.paddingVertical = 10})
      : super(key: key);

  final double width;
  final double height;
  final double paddingHorizontal;
  final double paddingVertical;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: paddingHorizontal, right: 7, bottom: paddingVertical),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                width: width,
                height: height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tether (USDT)',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(fontSize: 12)),
                          Text(
                            '2000 USDT',
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(fontSize: 14),
                          ),
                          Text(
                            '\$175 USD',
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RichText(
                            textAlign: TextAlign.end,
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child:
                                      SvgPicture.asset('assets/svgs/ic-up.svg'),
                                ),
                                TextSpan(
                                    text: " +15%",
                                    style:
                                        Theme.of(context).textTheme.headline3),
                              ],
                            ),
                          ),
                          AutoSizeText(
                            '897,000 CSPR',
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(fontSize: 11),
                          ),
                          Text(
                            '(24h)',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(fontSize: 11),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 7, right: paddingHorizontal, bottom: paddingVertical),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                width: width,
                height: height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tether (USDT)',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(fontSize: 12)),
                          Text(
                            '2000 USDT',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(fontSize: 14),
                          ),
                          Text(
                            '\$175 USD',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RichText(
                            textAlign: TextAlign.end,
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: SvgPicture.asset(
                                      'assets/svgs/ic-down.svg'),
                                ),
                                TextSpan(
                                    text: " -15%",
                                    style:
                                        Theme.of(context).textTheme.headline5),
                              ],
                            ),
                          ),
                          AutoSizeText(
                            '897,000 CSPR',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(fontSize: 11),
                          ),
                          Text(
                            '(24h)',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(fontSize: 11),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: paddingHorizontal, right: 7, bottom: paddingVertical),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                width: width,
                height: height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tether (USDT)',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(fontSize: 12)),
                          Text(
                            '2000 USDT',
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(fontSize: 14),
                          ),
                          Text(
                            '\$175 USD',
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RichText(
                            textAlign: TextAlign.end,
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child:
                                      SvgPicture.asset('assets/svgs/ic-up.svg'),
                                ),
                                TextSpan(
                                    text: " +15%",
                                    style:
                                        Theme.of(context).textTheme.headline3),
                              ],
                            ),
                          ),
                          AutoSizeText(
                            '897,000 CSPR',
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(fontSize: 11),
                          ),
                          Text(
                            '(24h)',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(fontSize: 11),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 7, right: paddingHorizontal, bottom: paddingVertical),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                width: width,
                height: height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tether (USDT)',
                              style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: 12)),
                          Text(
                            '2000 USDT',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(fontSize: 14),
                          ),
                          Text(
                            '\$175 USD',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RichText(
                            textAlign: TextAlign.end,
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: SvgPicture.asset(
                                      'assets/svgs/ic-down.svg'),
                                ),
                                TextSpan(
                                    text: " -15%",
                                    style:
                                        Theme.of(context).textTheme.headline5),
                              ],
                            ),
                          ),
                          AutoSizeText(
                            '897,000 CSPR',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(fontSize: 11),
                          ),
                          Text(
                            '(24h)',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(fontSize: 11),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
