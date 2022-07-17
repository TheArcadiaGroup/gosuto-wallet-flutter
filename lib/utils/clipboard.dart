import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

import '../components/dialog.dart';

class AppClipboard {
  static void copyToClipboard(String text,
      {GosutoDialog? dialog, Function? func}) {
    Clipboard.setData(
      ClipboardData(text: text),
    );

    if (dialog != null) {
      return;
    }

    if (func != null) {
      func();
      return;
    }

    Toast.show(
      "Copied!",
      duration: Toast.lengthLong,
      gravity: Toast.bottom,
      // backgroundColor: Theme.of(context).colorScheme.,
      // textColor: Colors.white,
    );
  }
}
