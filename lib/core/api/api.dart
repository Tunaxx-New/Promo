import 'package:promo/shared/widgets/api_form/api_client.dart';
import 'package:flutter/widgets.dart';

final api = ApiClient(
  baseUrl: 'http://46.8.31.215:8100',
  languageProvider: () =>
      WidgetsBinding.instance.platformDispatcher.locale.languageCode,
);
