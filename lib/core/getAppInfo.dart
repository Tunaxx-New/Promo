import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:promo/shared/extensions/localization_extension.dart';

Future<String> getAppInfo(BuildContext context) async {
  final info = await PackageInfo.fromPlatform();

  String platform;

  if (kIsWeb) {
    platform = 'Web';
  } else if (Platform.isAndroid) {
    platform = 'Android';
  } else if (Platform.isIOS) {
    platform = 'iOS';
  } else if (Platform.isWindows) {
    platform = 'Windows';
  } else if (Platform.isLinux) {
    platform = 'Linux';
  } else if (Platform.isMacOS) {
    platform = 'macOS';
  } else {
    platform = 'Unknown';
  }

  return context.l10n.appVersion(
    info.version,
    info.buildNumber,
    platform
  );
}
