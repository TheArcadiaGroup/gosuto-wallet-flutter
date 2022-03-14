import 'package:flutter/material.dart';

class CustomWidgets {
  static Widget textField(
    BuildContext context,
    String label, {
    Function? onChanged,
    double borderRadius = 18,
    bool enable = true,
    TextEditingController? controller,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      enabled: enable,
      onChanged: (text) => {onChanged != null ? onChanged(text) : null},
      cursorColor: Theme.of(context).colorScheme.onSurface,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          // suffixIconConstraints:
          //     const BoxConstraints.expand(width: 15, height: 15),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onSecondary, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onSecondary, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          contentPadding: const EdgeInsets.only(left: 20, right: 20),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18.0))),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelStyle: Theme.of(context).textTheme.bodyText1,
          labelText: label,
          labelStyle: Theme.of(context).textTheme.bodyText1,
          hintText: label,
          hintStyle: Theme.of(context).textTheme.bodyText2),
    );
  }
}
