import 'package:flutter/material.dart';
import 'package:promo/features/authorization/authorization_page.dart';
import 'package:promo/features/main_page.dart';
import 'package:promo/shared/widgets/authorization/splash_page.dart';

class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const authorization = '/authorization';

  static Map<String, WidgetBuilder> get routes => {
    splash: (_) => const SplashPage(),
    home: (_) => const MainPage(),
    authorization: (_) => const AuthorizationPage(),
  };
}
