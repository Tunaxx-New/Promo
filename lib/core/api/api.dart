import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:promo/shared/widgets/api_form/api_client.dart';
import 'package:flutter/widgets.dart';

final api = ApiClient(
  baseUrl: dotenv.env['API_BASE_URL'] ?? 'ttp://localhost:8000',
  languageProvider: () =>
      WidgetsBinding.instance.platformDispatcher.locale.languageCode,
);
