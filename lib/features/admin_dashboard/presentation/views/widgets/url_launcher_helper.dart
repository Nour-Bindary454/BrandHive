import 'package:url_launcher/url_launcher.dart';

void launchURL(String url) async {
  try {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } catch (_) {}
}
