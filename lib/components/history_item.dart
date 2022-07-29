import 'package:casper_dart_sdk/casper_dart_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:gosuto/models/models.dart';
import 'package:gosuto/services/service.dart';
import 'package:gosuto/themes/theme.dart';
import 'package:gosuto/utils/utils.dart';

class HistoryItem extends StatefulWidget {
  const HistoryItem(
      {Key? key,
      required this.deploy,
      required this.wallet,
      this.onTap,
      this.disabled,
      this.isSelected,
      this.subTitle = ''})
      : super(key: key);

  final DeployModel deploy;
  final WalletModel wallet;
  final String subTitle;
  final bool? disabled;
  final bool? isSelected;
  final Function? onTap;

  bool get _disabled => disabled == null ? false : disabled!;
  bool get _isSelected => isSelected == null ? false : isSelected!;

  @override
  _HistoryItemState createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  var _containerColor = ThemeService().isDarkMode
      ? AppTheme.darkTheme.colorScheme.secondaryContainer
      : AppTheme.lightTheme.colorScheme.secondaryContainer;
  var _titleColor = ThemeService().isDarkMode
      ? AppTheme.darkTheme.textTheme.headline4?.color
      : AppTheme.lightTheme.textTheme.headline4?.color;
  var _dateColor = ThemeService().isDarkMode
      ? AppTheme.darkTheme.textTheme.subtitle1?.color
      : AppTheme.lightTheme.textTheme.subtitle1?.color;
  var _sendColor = ThemeService().isDarkMode
      ? AppTheme.darkTheme.textTheme.headline5?.color
      : AppTheme.lightTheme.textTheme.headline5?.color;
  var _receivedColor = ThemeService().isDarkMode
      ? AppTheme.darkTheme.textTheme.headline3?.color
      : AppTheme.lightTheme.textTheme.headline3?.color;

  @override
  void didUpdateWidget(covariant HistoryItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    _containerColor = widget._isSelected
        ? const Color(0xFF725DFF)
        : ThemeService().isDarkMode
            ? AppTheme.darkTheme.colorScheme.secondaryContainer
            : AppTheme.lightTheme.colorScheme.secondaryContainer;

    _titleColor = widget._isSelected
        ? Colors.white
        : ThemeService().isDarkMode
            ? AppTheme.darkTheme.textTheme.headline4?.color
            : AppTheme.lightTheme.textTheme.headline4?.color;

    _dateColor = widget._isSelected
        ? Colors.white
        : ThemeService().isDarkMode
            ? AppTheme.darkTheme.textTheme.subtitle1?.color
            : AppTheme.lightTheme.textTheme.subtitle1?.color;

    _sendColor = widget._isSelected
        ? Colors.white
        : ThemeService().isDarkMode
            ? AppTheme.darkTheme.textTheme.headline5?.color
            : AppTheme.lightTheme.textTheme.headline5?.color;

    _receivedColor = widget._isSelected
        ? Colors.white
        : ThemeService().isDarkMode
            ? AppTheme.darkTheme.textTheme.headline3?.color
            : AppTheme.lightTheme.textTheme.headline3?.color;
  }

  @override
  Widget build(BuildContext context) {
    var deployName = '';
    var publicKey = widget.wallet.publicKey.toLowerCase();
    var historyItemStyle = 0;

    var amount = widget.deploy.executionTypeId != 2
        ? double.parse(CasperClient.fromWei(widget.deploy.amount.toString()))
        : 0.0;

    switch (widget.deploy.executionTypeId) {
      case 1:
        // WASM Deploy
        historyItemStyle = 1;
        deployName = 'wasm'.tr;
        break;
      case 2:
        // Contract interaction
        deployName = 'contract_interaction'.tr;

        if (widget.deploy.entryPoint?.name == 'delegate' ||
            widget.deploy.entryPoint?.name == 'undelegate') {
          historyItemStyle = 3;
          amount = double.parse(
              CasperClient.fromWei(widget.deploy.amount.toString()));
        }
        break;
      case 6:
      default:
        // Transfer
        deployName = 'transfer'.tr;

        if (widget.deploy.callerPublicKey.toLowerCase() == publicKey) {
          historyItemStyle = 3;
          deployName = 'sent'.tr;
        }
        break;
    }

    return InkWell(
      splashColor: Colors.red,
      onTap: () {
        if (!widget._disabled && widget.onTap != null) {
          widget.onTap!();
        }

        setState(() {
          _containerColor = !widget._isSelected
              ? const Color(0xFF725DFF)
              : Theme.of(context).colorScheme.secondaryContainer;

          _titleColor = !widget._isSelected
              ? Colors.white
              : Theme.of(context).textTheme.headline4?.color;

          _dateColor = !widget._isSelected
              ? Colors.white
              : ThemeService().isDarkMode
                  ? AppTheme.darkTheme.textTheme.subtitle1?.color
                  : AppTheme.lightTheme.textTheme.subtitle1?.color;
        });
      },
      // onTap: widget._disabled ? null : widget.onTap as void Function()?,
      child: Container(
        decoration: BoxDecoration(
          color: _containerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (widget.deploy.errorMessage != null)
                          SvgPicture.asset('assets/svgs/ic-failed.svg'),
                        Padding(
                          padding: EdgeInsets.only(
                              left: widget.deploy.errorMessage == null ? 0 : 8),
                          child: Text(
                            deployName,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(fontSize: 12, color: _titleColor),
                          ),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          widget.subTitle,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(fontSize: 10),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      GetTimeAgo.parse(
                          DateTime.parse(widget.deploy.timestamp).toLocal(),
                          pattern: 'LLL d, hh:mm:ss a'),
                      overflow: TextOverflow.clip,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.normal,
                          color: _dateColor),
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
                            color: widget._isSelected
                                ? Colors.white
                                : Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer)),
                  ],
                ),
              if (historyItemStyle == 1 || historyItemStyle == 3)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('-${NumberUtils.format(amount)} CSPR',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(color: _sendColor)),
                    const SizedBox(height: 5),
                    Text(
                      NumberUtils.formatCurrency(
                          amount * (widget.deploy.rate ?? 0)),
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(color: _sendColor),
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
                          ?.copyWith(fontSize: 13, color: _receivedColor),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      NumberUtils.formatCurrency(
                          amount * (widget.deploy.rate ?? 0)),
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          ?.copyWith(color: _receivedColor),
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
