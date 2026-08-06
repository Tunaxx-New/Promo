import 'package:flutter/material.dart';
import 'package:promo/app/routes.dart';
import 'package:promo/l10n/app_localizations.dart';
import 'package:promo/shared/theme/app_theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  static _AppState of(BuildContext context) =>
      context.findAncestorStateOfType<_AppState>()!;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
      theme: AppTheme.light(),
    );
  }
}
