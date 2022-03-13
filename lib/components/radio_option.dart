import 'package:flutter/material.dart';
import 'package:gosuto/services/service.dart';
import 'package:gosuto/utils/utils.dart';

import '../themes/colors.dart';

class GosutoRadioOption<T> extends StatefulWidget {
  final T value;
  final T? groupValue;
  final String label;
  final String text;
  final ValueChanged<T?> onChanged;

  const GosutoRadioOption({
    Key? key,
    required this.value,
    this.groupValue,
    required this.label,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  bool get _selected => value == groupValue;

  @override
  _RadioState<T> createState() => _RadioState<T>();
}

class _RadioState<T> extends State<GosutoRadioOption<T>> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onChanged(widget.value),
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        height: 105,
        padding: const EdgeInsets.all(25),
        duration: AppConstants.duration,
        decoration: BoxDecoration(
          color: widget._selected
              ? AppLightColors.tabBarIndicatorColor
              : Theme.of(context).colorScheme.secondary,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 2, right: 20),
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
                  child: Visibility(
                    visible: widget._selected,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(
                          side: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        color: Color(0xFF4F4F4F),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: widget._selected
                            ? Colors.white
                            : Theme.of(context).textTheme.bodyText1?.color,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.text,
                  style: TextStyle(
                      fontSize: 14,
                      color: widget._selected
                          ? Colors.white
                          : ThemeService().isDarkMode
                              ? Colors.white
                              : AppLightColors.textColor1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
