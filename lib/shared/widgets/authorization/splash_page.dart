import 'package:flutter/material.dart';
import 'package:promo/app/routes.dart';
import 'package:promo/core/api/api.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';
import 'package:promo/shared/widgets/authorization/authorization_service.dart';
import 'package:promo/shared/widgets/error_handler.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _auth = AuthorizationService();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final token = await _auth.refreshToken;

    if (token == null) {
      _goToAuthorization();
      return;
    }

    try {
      final json = await api.request(
        route: '/auth/refresh-token',
        method: HttpMethod.post,
        body: {"refresh_token": token},
      );

      await _auth.saveAccessToken(json['access_token']);
      await _auth.saveRefreshToken(json['refresh_token']);

      _goToMain();
    } catch (e) {
      ErrorHandler.show(context, e);
      _goToAuthorization();
    }
  }

  void _goToMain() {
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  void _goToAuthorization() {
    Navigator.pushReplacementNamed(context, AppRoutes.authorization);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
