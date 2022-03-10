import 'package:flutter/material.dart';
import 'package:gosuto/services/service.dart';

import '../themes/colors.dart';

class GosutoRadioOption<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String label;
  final String text;
  final ValueChanged<T?> onChanged;

  const GosutoRadioOption(
      {Key? key,
      required this.value,
      this.groupValue,
      required this.label,
      required this.text,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 20),
                width: 18,
                height: 18,
                decoration: ShapeDecoration(
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  color: const Color(0xffc4c4c4).withOpacity(0.5),
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      height: 1.625,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                text,
                style: TextStyle(
                    fontSize: 14,
                    color: ThemeService().isDarkMode
                        ? Colors.white
                        : AppLightColors.textColor1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
