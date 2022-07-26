import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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

    EasyLoading.showToast(
      "Copied!",
      duration: const Duration(seconds: 3),
      toastPosition: EasyLoadingToastPosition.bottom,
    );
  }
}
