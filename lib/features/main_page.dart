import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:promo/app/app.dart';
import 'package:promo/app/routes.dart';
import 'package:promo/core/api/api.dart';
import 'package:promo/core/api/minio.dart';
import 'package:promo/features/authorization/widgets/delete_user_profile.dart';
import 'package:promo/features/authorization/widgets/update_user_profile.dart';
import 'package:promo/features/cards/cards_page.dart';

import 'package:promo/features/home/home_page.dart';
import 'package:promo/features/scanner/scanner_page.dart';
import 'package:promo/features/promocodes/promocodes_page.dart';
import 'package:promo/features/company/company_page.dart';
import 'package:promo/shared/models/company.dart';
import 'package:promo/shared/models/payment_check.dart';
import 'package:promo/shared/models/user_card.dart';
import 'package:promo/shared/widgets/bonuses/bonuses_details.dart';
import 'package:promo/shared/widgets/bonuses/bonuses_plate.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';
import 'package:promo/shared/widgets/authorization/authorization_service.dart';
import 'package:promo/shared/widgets/card/card_plate.dart';
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
  final _minio = MinioStorage();

  int _currentIndex = 0;

  bool? _isCompany;

  String? _activatedPromocodeId;

  List<Company> _companies = [];
  int _selectedCompanyIndex = 0;

  double _bonuses = 0.0;

  List<dynamic> _composePromocodes = [];
  int _selectedComposePromocodesIndex = 0;

  final List<PaymentCheck> _checks = [];

  final List<UserCard> _cards = [];

  String? _cardCode;
  int _cardCodeVersion = 0;
  Timer? _cardCodeTimer;

  @override
  void initState() {
    super.initState();
    _refresh();

    _cardCodeTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _loadCardCode(isShowError: false),
    );
  }

  @override
  void dispose() {
    _cardCodeTimer?.cancel();
    super.dispose();
  }

  Future<T> _measure<T>(String name, Future<T> Function() action) async {
    final stopwatch = Stopwatch()..start();

    try {
      return await action();
    } finally {
      stopwatch.stop();
      debugPrint('⏱ $name: ${stopwatch.elapsedMilliseconds} ms');
    }
  }

  Future<void> _refresh() async {
    _isCompany = null;
    final total = Stopwatch()..start();

    await Future.wait([
      _measure('loadCompanies', _loadCompanies),
      _measure('loadComposePromocodes', _loadComposePromocodes),
      _measure('loadChecks', _loadChecks),
    ]);

    await _measure('loadUser', _loadUser);
    await _measure('loadCardCode', () => _loadCardCode(isShowError: false));

    total.stop();

    debugPrint('⏱ TOTAL refresh: ${total.elapsedMilliseconds} ms');
  }

  Future<void> _loadComposePromocodes() async {
    try {
      final response = await api.request(
        route: '/promo/promocode/my',
        method: HttpMethod.get,
      );

      setState(() {
        _composePromocodes = List<dynamic>.from(response['data']);
      });
    } catch (e) {
      ErrorHandler.show(context, e);

      setState(() {
        _composePromocodes = [];
      });
    }
  }

  Future<void> _loadCompanies() async {
    try {
      final response = await api.request(
        route: '/promo/list_companies',
        method: HttpMethod.get,
      );

      setState(() {
        _companies
          ..clear()
          ..addAll(
            (response['data'] as List)
                .map((item) => Company.fromJson(item))
                .toList(),
          );
      });
    } catch (e) {
      ErrorHandler.show(context, e);

      setState(() {
        _companies.clear();
      });
    }
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
        _cards
          ..clear()
          ..addAll(
            (response['cards'] as List).map((item) {
              Company? company;
              for (final item_ in _companies) {
                if (item_.bin == item['company_bin']) {
                  company = item_;
                  break;
                }
              }

              double bonusesSum = 0.0;
              _bonuses = 0.0;

              for (final check in _checks) {
                _bonuses += check.bonusSum;

                if (item['card_id'] == check.cardId) {
                  bonusesSum += check.bonusSum;
                }
              }

              return UserCard.fromJson(item, company, bonusesSum);
            }).toList(),
          );
      });
    } catch (e) {
      if (!mounted) return;
      ErrorHandler.show(context, e);
      setState(() {
        _isCompany = false;
        _bonuses = 0;
        _cards.clear();
      });
    }
  }

  Future<void> _loadChecks() async {
    try {
      final response = await api.request(
        route: '/bonuses/checks',
        method: HttpMethod.get,
      );

      setState(() {
        _checks
          ..clear()
          ..addAll(
            (response['data'] as List).map((item) {
              Company? company;

              for (final item_ in _companies) {
                if (item_.bin == item['company_bin']) {
                  company = item_;
                  break;
                }
              }

              return PaymentCheck.fromJson(item);
            }).toList(),
          );
      });
    } catch (e) {
      if (!mounted) return;

      ErrorHandler.show(context, e);

      setState(() {
        _checks.clear();
      });
    }
  }

  Future<void> _loadCardCode({bool isShowError = true}) async {
    try {
      final response = await api.request(
        route: '/auth/card_code/get',
        method: HttpMethod.get,
      );

      if (!mounted) return;

      _cardCodeTimer?.cancel();
      _cardCodeTimer = null;

      setState(() {
        _cardCode = response['value'].toString();
        _cardCodeVersion++;
      });
    } catch (e) {
      if (!mounted) return;

      if (isShowError) ErrorHandler.show(context, e);

      setState(() {
        _cardCode = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = _isCompany == null;

    final pages = [
      //HomePage(onRefresh: _refresh, companies: _companies),
      //ScannerPage(
      //  isActive: _currentIndex == 1,
      //  onPromocodeActivated: (id) {
      //    setState(() {
      //      _activatedPromocodeId = id;
      //      _currentIndex = 2;
      //    });
      //  },
      //),
      CardsPage(onRefresh: _refresh, cards: _cards),
      // PromocodesPage(activatedPromocodeId: _activatedPromocodeId),
      if (_isCompany == true) const CompanyPage(),
      const SizedBox.shrink(),
    ];

    final titles = [
      // context.l10n.homeTitle,
      // context.l10n.scannerTitle,
      context.l10n.myCards,
      // context.l10n.promocodesTitle,
      if (_isCompany == true) context.l10n.companyTitle,
      '',
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
                  case 'delete_user_profile':
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DeleteUserProfileWidget(
                          user: {},
                          onDeleted: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutes.splash,
                              (route) => false,
                            );
                          },
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
                PopupMenuItem(
                  value: 'delete_user_profile',
                  child: Row(
                    children: [
                      Icon(Icons.delete_forever),
                      SizedBox(width: 12),
                      Text(context.l10n.userDeleteTitle),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            if (_currentIndex == 0)
              Column(
                children: [
                  if (_companies.isNotEmpty &&
                      _companies.length - 1 >= _selectedCompanyIndex)
                    BonusesPlate(
                      bonusSum: _bonuses,
                      imageUrl: _minio.imageUrlFromBucket(
                        'companies',
                        '${_companies[_selectedCompanyIndex].id}.png',
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BonusesDetails(checks: _checks),
                          ),
                        );
                      },
                      onUpdate: () async {
                        await _loadUser();
                      },
                    ),

                  if (_cardCode != null)
                    CardPlate(
                      barcode: _cardCode!,
                      onExpired: _loadCardCode,
                      key: ValueKey(_cardCodeVersion),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _loadCardCode,
                          child: Text(context.l10n.get_code_from_cassier),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _refresh,
                        child: const Icon(Icons.refresh),
                      ),
                    ),
                  ),
                ],
              ),

            Expanded(
              child: IndexedStack(index: _currentIndex, children: pages),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          key: ValueKey(_isCompany),
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
          onTap: (index) => setState(() => _currentIndex = index),
          items: [
            //BottomNavigationBarItem(
            //  icon: Icon(Icons.home_outlined),
            //  activeIcon: Icon(Icons.home),
            //  label: context.l10n.homeTitle,
            //),
            //BottomNavigationBarItem(
            //  icon: Icon(Icons.qr_code_scanner_outlined),
            //  activeIcon: Icon(Icons.qr_code_scanner),
            //  label: context.l10n.scannerTitle,
            //),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard),
              activeIcon: Icon(Icons.card_giftcard),
              label: context.l10n.myCards,
            ),
            //BottomNavigationBarItem(
            //  icon: Icon(Icons.local_offer_outlined),
            //  activeIcon: Icon(Icons.local_offer),
            //  label: context.l10n.promocodesDescription,
            //),
            if (_isCompany == true)
              BottomNavigationBarItem(
                icon: Icon(Icons.business_outlined),
                activeIcon: Icon(Icons.business),
                label: context.l10n.companyTitle,
              ),
            const BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
          ],
        ),
      ),
    );
  }
}
