import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(String? url) async {
  if (url == null) return;

  final uri = Uri.parse(url);

  final success = await launchUrl(uri);
  if (!success) {
    debugPrint('Could not launch $url');
  }
}
