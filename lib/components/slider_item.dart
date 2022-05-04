import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SliderItem extends StatelessWidget {
  const SliderItem(
      {Key? key,
      required this.width,
      required this.height,
      this.paddingHorizontal = 10,
      this.paddingVertical = 10,
        this.centerPadding = 5
      })
      : super(key: key);

  final double width;
  final double height;
  final double paddingHorizontal;
  final double paddingVertical;
  final double centerPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildItem(context, true, true),
            _buildItem(context, false, false),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildItem(context, true, true),
            _buildItem(context, false, false),
          ],
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, bool isGrowing, bool isLeft) {
    return Padding(
      padding: EdgeInsets.only(
          left: isLeft ? paddingHorizontal : centerPadding,
          right: isLeft ? centerPadding : paddingHorizontal,
          bottom: paddingVertical),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Theme.of(context).colorScheme.secondary),
          color: Theme.of(context).colorScheme.secondaryContainer,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(12),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, -1), // changes position of shadow
            ),
          ],
        ),
        width: width - 2 * (paddingHorizontal) - centerPadding,
        height: height - paddingVertical,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tether (USDT)',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(fontSize: 12),
                    ),
                    Text(
                      '2000 USDT',
                      overflow: TextOverflow.ellipsis,
                      style: isGrowing
                          ? Theme.of(context)
                              .textTheme
                              .headline3
                              ?.copyWith(fontSize: 14)
                          : Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(fontSize: 14),
                    ),
                    Text(
                      '\$175 USD',
                      style: isGrowing
                          ? Theme.of(context)
                              .textTheme
                              .headline3
                              ?.copyWith(fontSize: 12)
                          : Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(fontSize: 12),
                    ),
                  ],
                ),
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
                          child: isGrowing ? SvgPicture.asset('assets/svgs/ic-up.svg') : SvgPicture.asset('assets/svgs/ic-down.svg'),
                        ),
                        TextSpan(
                          text: isGrowing ? " +15%" : " -15%",
                          style: isGrowing
                              ? Theme.of(context)
                                  .textTheme
                                  .headline3
                                  ?.copyWith(fontSize: 10)
                              : Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  AutoSizeText(
                    '897,000 CSPR',
                    style: isGrowing
                        ? Theme.of(context)
                            .textTheme
                            .headline3
                            ?.copyWith(fontSize: 11)
                        : Theme.of(context)
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
    );
  }
}
