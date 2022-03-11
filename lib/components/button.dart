import 'dart:core';

import 'package:flutter/material.dart';

enum GosutoButtonStyle { fill, text }

class GosutoButton extends StatefulWidget {
  final String text;
  final bool? disabled;
  final GosutoButtonStyle? style;
  final Function? onPress;

  const GosutoButton({
    Key? key,
    required this.text,
    this.disabled,
    this.style,
    this.onPress,
  }) : super(key: key);

  bool get _disabled => disabled == null ? false : disabled!;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<GosutoButton> {
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
          backgroundColor: widget.style == GosutoButtonStyle.fill
              ? Theme.of(context)
                  .colorScheme
                  .background
                  .withOpacity(widget._disabled ? 0.5 : 1)
              : Colors.transparent,
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            height: 1.5,
            color: widget.style == GosutoButtonStyle.fill
                ? Colors.white
                : Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.color
                    ?.withOpacity(widget._disabled ? 0.5 : 1),
          ),
        ),
        onPressed: widget.onPress as void Function()?,
      ),
    );
  }
}
