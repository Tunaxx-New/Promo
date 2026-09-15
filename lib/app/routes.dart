import 'package:flutter/material.dart';
import 'package:promo/features/advanced_main_page.dart';
import 'package:promo/features/authorization/authorization_page.dart';
import 'package:promo/features/home/advanced_home_page.dart';
import 'package:promo/pages/unauthorized_screen.dart';
import 'package:promo/shared/widgets/authorization/splash_page.dart';

class AppRoutes {
  static const splash = '/';
  static const unauthorized = '/unauthorized';
  static const home = '/home';
  static const authorization = '/authorization';

  static Map<String, WidgetBuilder> get routes => {
    splash: (_) => const SplashPage(),
    unauthorized: (_) => const UnauthorizedPage(),
    home: (_) => const AdvancedMainPage(),
    authorization: (context) => AuthorizationPage(selected: ModalRoute.of(context)?.settings.arguments as int? ?? 0),
  };
}
