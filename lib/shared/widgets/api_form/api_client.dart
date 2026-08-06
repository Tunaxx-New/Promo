import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:promo/shared/widgets/api_form/api_exception.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';
import 'package:promo/shared/widgets/authorization/authorization_service.dart';

class ApiClient {
  final String baseUrl;
  String Function()? languageProvider;

  ApiClient({required this.baseUrl, this.languageProvider});

  Future<Map<String, dynamic>> request({
    required String route,
    required HttpMethod method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('$baseUrl$route');
    final token = await AuthorizationService().accessToken;

    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      if (languageProvider != null) 'Accept-Language': languageProvider!(),
      'Authorization': 'Bearer $token',
      ...?headers,
    };

    late http.Response response;

    switch (method.name.toUpperCase()) {
      case 'GET':
        response = await http.get(uri, headers: requestHeaders);
        break;

      case 'POST':
        response = await http.post(
          uri,
          headers: requestHeaders,
          body: jsonEncode(body),
        );
        break;

      case 'PUT':
        response = await http.put(
          uri,
          headers: requestHeaders,
          body: jsonEncode(body),
        );
        break;

      case 'PATCH':
        response = await http.patch(
          uri,
          headers: requestHeaders,
          body: jsonEncode(body),
        );
        break;

      case 'DELETE':
        response = await http.delete(
          uri,
          headers: requestHeaders,
          body: jsonEncode(body),
        );
        break;

      default:
        throw Exception('Unsupported HTTP method: $method');
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return {};
      }

      final decoded = jsonDecode(response.body);

      if (decoded is Map<String, dynamic>) {
        return decoded;
      }

      if (decoded is List<dynamic>) {
        return {'data': decoded};
      }

      return {};
    }

    String? message;
    try {
      final json = jsonDecode(response.body);
      message = json["detail"];
    } catch (_) {}
    
    throw ApiException(statusCode: response.statusCode, message: message);
  }
}
