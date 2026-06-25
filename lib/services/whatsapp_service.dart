import 'package:url_launcher/url_launcher.dart';
import '../core/constants/app_strings.dart';

class WhatsAppService {
  /// Opens WhatsApp with a pre-filled message
  static Future<void> openChat({String message = 'Hello! I need assistance.'}) async {
    final encoded = Uri.encodeComponent(message);
    final number = AppStrings.phone.replaceAll(RegExp(r'[^0-9]'), '');
    final url = 'https://wa.me/91$number?text=$encoded';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  /// Opens WhatsApp with a product inquiry message
  static Future<void> inquireProduct(String productName) async {
    final message = 'Hi! I am interested in: $productName. Is it available?';
    await openChat(message: message);
  }

  /// Opens WhatsApp with an order message
  static Future<void> placeOrder(List<String> items) async {
    final list = items.map((e) => '• $e').join('\n');
    final message = 'Hi! I would like to order:\n$list\n\nPlease confirm availability.';
    await openChat(message: message);
  }
}
