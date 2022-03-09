import 'dart:core';

import 'package:flutter/material.dart';

enum GosutoButtonStyle { fill, text }

class GosutoButton extends StatelessWidget {
  final String text;
  final GosutoButtonStyle? style;
  final Function? onPress;

  const GosutoButton({Key? key, required this.text, this.style, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          backgroundColor: style == GosutoButtonStyle.fill
              ? Theme.of(context).colorScheme.background
              : Colors.transparent,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            height: 1.5,
            color: style == GosutoButtonStyle.fill
                ? Colors.white
                : Theme.of(context).textTheme.bodyText1?.color,
          ),
        ),
        onPressed: onPress as void Function()?,
      ),
    );
  }
}
