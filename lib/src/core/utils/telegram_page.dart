import 'package:url_launcher/url_launcher.dart';

Future<void> openTelegramPage(String uri) async {
  var url = Uri.parse(uri);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  }
}