import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

import '../utils/size_config.dart';

class GosutoDialog extends YYDialog {
  EdgeInsets padding = EdgeInsets.symmetric(
    horizontal: getProportionateScreenWidth(20),
    vertical: 30,
  );

  YYDialog buildDialog(BuildContext? context, List<Widget> children) {
    SizeConfig().init(context!);

    return YYDialog().build(context)
      ..barrierColor = Colors.black.withOpacity(0.6)
      ..backgroundColor = Theme.of(context).scaffoldBackgroundColor
      ..borderRadius = 34
      ..width = getProportionateScreenWidth(372)
      ..widget(
        Padding(
          padding: padding,
          child: Column(
            children: children,
          ),
        ),
      )
      ..show();
  }
}
