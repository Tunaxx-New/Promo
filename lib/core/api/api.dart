import 'package:promo/shared/widgets/api_form/api_client.dart';
import 'package:flutter/widgets.dart';

final api = ApiClient(
  languageProvider: () =>
      WidgetsBinding.instance.platformDispatcher.locale.languageCode,
);
