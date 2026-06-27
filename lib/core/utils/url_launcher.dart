import 'package:url_launcher/url_launcher.dart';
import '../constants/app_strings.dart';

class UrlLauncherUtil {
  static Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> callPhone() => _launch(AppStrings.phoneUrl);
  static Future<void> openWhatsApp() => _launch(AppStrings.whatsappUrl);
  static Future<void> sendEmail() => _launch(AppStrings.emailUrl);
  static Future<void> openMaps() => _launch(AppStrings.mapsUrl);
  static Future<void> openPlayStore() => _launch(AppStrings.playStoreUrl);
  static Future<void> openAppStore() => _launch(AppStrings.appStoreUrl);
  static Future<void> openFacebook() => _launch('https://facebook.com');
  static Future<void> openInstagram() => _launch('https://instagram.com');
  static Future<void> openMatric() => _launch('https://www.matricservices.in/');
}
