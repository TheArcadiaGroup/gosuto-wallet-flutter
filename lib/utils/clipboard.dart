import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/dialog.dart';

class AppClipboard {
  static void copyToClipboard(String text, {GosutoDialog? dialog, Function? func}) {
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

    Fluttertoast.showToast(
      msg: "Copied!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      // backgroundColor: Theme.of(context).colorScheme.,
      // textColor: Colors.white,
    );
  }
}
