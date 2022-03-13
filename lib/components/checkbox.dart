import 'package:flutter/material.dart';
import 'package:gosuto/services/service.dart';
import 'package:gosuto/themes/colors.dart';
import 'package:gosuto/utils/utils.dart';

class GosutoCheckbox extends StatefulWidget {
  final bool isChecked;
  final String label;
  final ValueChanged onChanged;

  const GosutoCheckbox({
    Key? key,
    required this.isChecked,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CheckboxState createState() => _CheckboxState();
}

class _CheckboxState extends State<GosutoCheckbox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onChanged(widget.isChecked),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            height: 18,
            width: 18,
            margin: const EdgeInsets.only(right: 12),
            duration: AppConstants.duration,
            decoration: BoxDecoration(
              color: widget.isChecked
                  ? AppLightColors.tabBarIndicatorColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(5),
              border: widget.isChecked
                  ? null
                  : Border.all(
                      color: const Color(0xFF6D6D6D),
                      width: 1,
                    ),
            ),
            child: widget.isChecked
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  )
                : null,
          ),
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 12,
              color: ThemeService().isDarkMode
                  ? AppDarkColors.textColor1
                  : AppLightColors.textColor1,
            ),
          ),
        ],
      ),
    );
  }
}
