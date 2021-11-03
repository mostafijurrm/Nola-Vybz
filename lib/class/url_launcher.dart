import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static url(String url) async {
    if (canLaunch(url) != null) {
      launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}