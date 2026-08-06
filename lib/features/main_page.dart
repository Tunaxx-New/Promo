import 'package:flutter/material.dart';
import 'package:promo/app/app.dart';
import 'package:promo/core/api/api.dart';
import 'package:promo/features/authorization/widgets/update_user_profile.dart';

import 'package:promo/features/home/home_page.dart';
import 'package:promo/features/scanner/scanner_page.dart';
import 'package:promo/features/promocodes/promocodes_page.dart';
import 'package:promo/features/company/company_page.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';
import 'package:promo/shared/widgets/authorization/authorization_service.dart';
import 'package:promo/shared/widgets/error_handler.dart';
import 'package:promo/shared/widgets/loading/loading_overlay.dart';
import 'package:promo/shared/widgets/user/user_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _auth = AuthorizationService();
  final _user = UserService();

  int _currentIndex = 0;

  bool? _isCompany;

  String? _activatedPromocodeId;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final response = await api.request(
        route: '/auth/profile',
        method: HttpMethod.get,
      );

      await _user.saveUserId(response['id']);
      await _user.saveName(response['name']);

      setState(() {
        _isCompany = response['company_id'] != null;
      });
    } catch (e) {
      ErrorHandler.show(context, e);

      setState(() {
        _isCompany = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = _isCompany == null;

    final pages = [
      const HomePage(),
      ScannerPage(
        isActive: _currentIndex == 1,
        onPromocodeActivated: (id) {
          setState(() {
            _activatedPromocodeId = id;
            _currentIndex = 2;
          });
        },
      ),
      PromocodesPage(activatedPromocodeId: _activatedPromocodeId),
      if (_isCompany == true) const CompanyPage(),
    ];

    final titles = [
      context.l10n.homeTitle,
      context.l10n.scannerTitle,
      context.l10n.promocodesTitle,
      if (_isCompany == true) context.l10n.companyTitle,
    ];

    return LoadingOverlay(
      loading: loading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            titles[_currentIndex],
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            PopupMenuButton<Locale>(
              tooltip: context.l10n.localeName,
              initialValue: Localizations.localeOf(context),
              onSelected: (locale) {
                App.of(context).setLocale(locale);
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: Locale('en'), child: Text('🇺🇸 EN')),
                PopupMenuItem(value: Locale('ru'), child: Text('🇷🇺 RU')),
                PopupMenuItem(value: Locale('kk'), child: Text('🇰🇿 KK')),
              ],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Center(
                  child: Text(
                    Localizations.localeOf(context).languageCode.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),

            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) async {
                switch (value) {
                  case 'logout':
                    try {
                      api.request(
                        route: '/auth/logout',
                        method: HttpMethod.post,
                        body: {'refresh_token': _auth.refreshToken},
                      );
                    } catch (e) {
                      ErrorHandler.show(context, e);
                    }

                    await _auth.logout();

                    if (!context.mounted) return;

                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil('/', (_) => false);
                    break;
                  case 'update_user_profile':
                    final username = await _user.name;
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => UpdateUserProfileWidget(
                          user: {'name': username},
                          onUpdated: _loadUser,
                        ),
                      ),
                    );
                    break;
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 12),
                      Text(context.l10n.authorizationLogoutTitle),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'update_user_profile',
                  child: Row(
                    children: [
                      Icon(Icons.person_2_rounded),
                      SizedBox(width: 12),
                      Text(context.l10n.userUpdateTitle),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: IndexedStack(index: _currentIndex, children: pages),
        bottomNavigationBar: BottomNavigationBar(
          key: ValueKey(_isCompany),
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
          onTap: (index) => setState(() => _currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: context.l10n.homeTitle,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner_outlined),
              activeIcon: Icon(Icons.qr_code_scanner),
              label: context.l10n.scannerTitle,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer_outlined),
              activeIcon: Icon(Icons.local_offer),
              label: context.l10n.promocodesDescription,
            ),
            if (_isCompany == true)
              BottomNavigationBarItem(
                icon: Icon(Icons.business_outlined),
                activeIcon: Icon(Icons.business),
                label: context.l10n.companyTitle,
              ),
          ],
        ),
      ),
    );
  }
}
