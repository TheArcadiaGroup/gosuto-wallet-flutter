import 'package:url_launcher/url_launcher.dart';

class Urls {
  static Future<void> launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
    )) {
      throw 'Could not launch $url';
    }
  }
}
