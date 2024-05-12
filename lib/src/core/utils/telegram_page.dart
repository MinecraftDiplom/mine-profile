import 'package:url_launcher/url_launcher.dart';

Future<void> openTelegramPage(String uri) async {
  var url = Uri.parse(uri);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  }
}

Future<void> launchSupportMail() async {
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'support@kissota.ru',
    query: encodeQueryParameters(<String, String>{
      'subject': 'Письмо из мобильного приложения.',
    }),
  );
  if (await canLaunchUrl(emailLaunchUri)) {
    await launchUrl(emailLaunchUri);
  }
}
