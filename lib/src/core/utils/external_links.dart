import 'package:url_launcher/url_launcher.dart';
import '../constants/app_constants.dart';

abstract final class ExternalLinks {
  static Future<void> openWhatsApp({String? customMessage}) async {
    final messageQuery = customMessage != null
        ? '?text=${Uri.encodeComponent(customMessage)}'
        : '';
    final uri = Uri.parse('https://wa.me/${AppConstants.whatsappNumber}$messageQuery');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> callDispatch() async {
    final uri = Uri.parse('tel:${AppConstants.dispatchPhone}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
