import 'package:url_launcher/url_launcher.dart';

class Launcher{
  static Future<void> onLaunchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  static Future<void> onLaunchPhone(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  static Future<void> onLaunchEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(launchUri);
  }

  static String launchMap(String? lat, String? lng) {
    return "https://maps.google.com/maps?q=$lat%2C$lng&z=17&hl=ar";
  }
}