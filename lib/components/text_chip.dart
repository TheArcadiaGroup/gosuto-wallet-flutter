import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gosuto/themes/colors.dart';

import '../services/theme_service.dart';

class GosutoTextChip extends StatefulWidget {
  final String index;
  final String text;
  final bool? isEditable;

  const GosutoTextChip({
    Key? key,
    required this.index,
    required this.text,
    this.isEditable,
  }) : super(key: key);

  bool get _isEditable => isEditable == null ? false : isEditable!;

  @override
  _TextChipState createState() => _TextChipState();
}

class _TextChipState extends State<GosutoTextChip> {
  final _focusNode = FocusNode();
  bool _isFocusing = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocusing = _focusNode.hasFocus;
    });
    debugPrint("Focus: ${_focusNode.hasFocus.toString()}");
  }

  Widget _buildNormalState() {
    return Container(
      height: 42,
      padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
      decoration: BoxDecoration(
        color: ThemeService().isDarkMode
            ? Colors.white.withOpacity(0.1)
            : Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 9,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 24,
            width: 24,
            margin: const EdgeInsets.only(
              right: 6,
            ),
            decoration: BoxDecoration(
              color: ThemeService().isDarkMode
                  ? Colors.white.withOpacity(0.2)
                  : const Color(0xFFF1F1F1),
              shape: BoxShape.circle,
            ),
            child: Text(
              widget.index,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    height: 1.57,
                  ),
            ),
          ),
          Text(
            widget.text,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableState() {
    return DottedBorder(
      borderType: BorderType.RRect,
      dashPattern: _isFocusing ? const [4, 0] : const [4, 2],
      color: _isFocusing
          ? AppDarkColors.tabBarIndicatorColor
          : ThemeService().isDarkMode
              ? Colors.white.withOpacity(0.3)
              : Colors.black.withOpacity(0.4),
      radius: const Radius.circular(35),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(35)),
        child: Container(
          height: 38,
          padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
          decoration: BoxDecoration(
            color: ThemeService().isDarkMode
                ? Colors.white.withOpacity(0.1)
                : Colors.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: const BoxConstraints(
                  minWidth: 100,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 30,
                        minHeight: 30,
                      ),
                      prefixIcon: Container(
                        margin: const EdgeInsets.only(
                          right: 6,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isFocusing
                              ? AppDarkColors.tabBarIndicatorColor
                              : ThemeService().isDarkMode
                                  ? Colors.white.withOpacity(0.2)
                                  : const Color(0xFFF1F1F1),
                        ),
                        child: Text(
                          widget.index,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                            color: _isFocusing
                                ? Colors.white
                                : ThemeService().isDarkMode
                                    ? Colors.white
                                    : const Color(0xFF4F4F4F),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget._isEditable ? _buildEditableState() : _buildNormalState();
  }
}
