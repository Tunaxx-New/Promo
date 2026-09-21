import 'dart:async';

import 'package:flutter/material.dart';
import 'package:promo/app/routes.dart';
import 'package:promo/core/api/api.dart';
import 'package:promo/core/api/minio.dart';
import 'package:promo/features/authorization/widgets/delete_user_profile.dart';
import 'package:promo/features/authorization/widgets/update_user_profile.dart';
import 'package:promo/features/home/advanced_home_page.dart';
import 'package:promo/pages/about_screen.dart';
import 'package:promo/shared/extensions/localization_extension.dart';

import 'package:promo/shared/models/company.dart';
import 'package:promo/shared/models/payment_check.dart';
import 'package:promo/shared/models/service.dart';
import 'package:promo/shared/models/user.dart';
import 'package:promo/shared/models/user_card.dart';
import 'package:promo/shared/theme/app_strings.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';
import 'package:promo/shared/widgets/authorization/authorization_service.dart';
import 'package:promo/shared/widgets/card/card_plate.dart';
import 'package:promo/shared/widgets/error_handler.dart';
import 'package:promo/shared/widgets/loading/loading_overlay.dart';
import 'package:promo/shared/widgets/user/user_service.dart';

class AdvancedMainPage extends StatefulWidget {
  const AdvancedMainPage({super.key});

  @override
  State<AdvancedMainPage> createState() => _AdvancedMainPageState();
}

class _AdvancedMainPageState extends State<AdvancedMainPage> {
  final _user = UserService();
  final _auth = AuthorizationService();
  final _minio = MinioStorage();

  User? user;

  bool? _isCompany;
  List<Company> _companies = [];
  final List<PaymentCheck> _checks = [];
  final List<UserCard> _cards = [];
  final ValueNotifier<List<Service>> servicesNotifier = ValueNotifier([]);

  List<dynamic> _composePromocodes = [];
  int _selectedComposePromocodesIndex = 0;

  double _bonuses = 0.0;
  final ValueNotifier<double> _bonusesNotifier = ValueNotifier(0);
  void _setBonuses(double value) {
    _bonuses = value;
    _bonusesNotifier.value = value;
  }

  String? _cardCode;
  int _cardCodeVersion = 0;
  Timer? _cardCodeTimer;

  // Async loading statuses
  bool _isRefreshing = false;
  bool _checksLoading = false;
  bool _userLoading = false;
  bool _cardCodeLoading = false;
  bool _servicesLoading = false;

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
    if (_isRefreshing) {
      debugPrint('⚠️ refresh already running');
      return;
    }

    _isRefreshing = true;

    try {
      _isCompany = null;
      final total = Stopwatch()..start();

      await Future.wait([
        _measure('loadCompanies', _loadCompanies),
        _measure('loadComposePromocodes', _loadComposePromocodes),
      ]);

      unawaited(_measure('loadUser', _loadUser));
      unawaited(_measure('loadChecks', _loadChecks));
      unawaited(
        _measure('loadCardCode', () => _loadCardCode(isShowError: false)),
      );
      unawaited(_measure('loadServices', _loadServices));

      total.stop();

      debugPrint('⏱ TOTAL refresh: ${total.elapsedMilliseconds} ms');
    } finally {
      _isRefreshing = false;
    }
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
    if (_userLoading) {
      debugPrint('⚠️ loadUser already running');
      return;
    }

    _userLoading = true;

    try {
      final response = await api.request(
        route: '/auth/profile',
        method: HttpMethod.get,
      );

      await _user.saveUserId(response['id']);
      await _user.saveName(response['name']);

      setState(() {
        user = User.fromJson(response);
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

              return UserCard.fromJson(item, company, _bonuses);
            }).toList(),
          );
      });
    } catch (e) {
      if (!mounted) return;
      ErrorHandler.show(context, e);
      setState(() {
        _isCompany = false;
        _setBonuses(0);
        _cards.clear();
      });
    } finally {
      _userLoading = false;
    }
  }

  Future<void> _loadChecks() async {
    if (_checksLoading) {
      debugPrint('⚠️ loadChecks already running');
      return;
    }

    _checksLoading = true;

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

        // Update bonuses global
        var bonuses = 0.0;
        for (final check in _checks) {
          bonuses += check.bonusSum;
        }
        _setBonuses(bonuses);

        // Update card based
        for (var i = 0; i < _cards.length; i++) {
          final card = _cards[i];

          var bonusesSum = 0.0;

          for (final check in _checks) {
            if (check.cardId == card.cardId) {
              bonusesSum += check.bonusSum;
            }
          }

          _cards[i] = UserCard.fromJson(
            card.toJson(),
            card.company,
            bonusesSum,
          );
        }
      });
    } catch (e) {
      if (!mounted) return;

      ErrorHandler.show(context, e);

      setState(() {
        _checks.clear();
      });
    } finally {
      _checksLoading = false;
    }
  }

  Future<void> _loadCardCode({bool isShowError = true}) async {
    if (_cardCodeLoading) {
      debugPrint('⚠️ cardCodeLoading already running');
      return;
    }

    _cardCodeLoading = true;

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
    } finally {
      _cardCodeLoading = false;
    }
  }

  Future<void> _loadServices({
    bool isShowError = true,
    bool refresh = false,
  }) async {
    if (_servicesLoading) {
      debugPrint('⚠️ servicesLoading already running');
      return;
    }

    _servicesLoading = true;

    try {
      final response = await api.request(
        route: '/promotions/services?company_id=${AppStrings.companyId}',
        method: HttpMethod.get,
      );

      var services = (response['data'] as List)
          .map((json) => Service.fromJson(json as Map<String, dynamic>, _minio))
          .toList();

      for (final service in services) {
        final company = _companies.cast<Company?>().firstWhere(
          (company) => company?.id == service.companyId,
          orElse: () => null,
        );
        service.companyName = company?.name;
      }

      if (!mounted) return;

      setState(() {
        servicesNotifier.value = services;
      });
    } catch (e) {
      debugPrint(e.toString());

      if (!mounted) return;

      if (isShowError) {
        ErrorHandler.show(context, e);
      }
    } finally {
      _servicesLoading = false;
    }
  }

  void _openBonuses() {}

  void _openCars() {
    debugPrint('ProfilePage: tap "Мои машины"');
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            '${context.l10n.my_cars} ${context.l10n.is_not_available_yet}',
            style: TextStyle(fontSize: 18),
          ),
        );
      },
    );
  }

  void _openNotifications() {
    debugPrint('ProfilePage: tap "Уведомления"');
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            '${context.l10n.notifications} ${context.l10n.is_not_available_yet}',
            style: TextStyle(fontSize: 18),
          ),
        );
      },
    );
  }

  void _openSettings() {
    debugPrint('ProfilePage: tap "Настройки"');
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            '${context.l10n.settings} ${context.l10n.is_not_available_yet}',
            style: TextStyle(fontSize: 18),
          ),
        );
      },
    );
  }

  void _openAbout() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => AboutPage()));
  }

  void _updateUser() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => UpdateUserProfileWidget(
          user: {'name': user?.name},
          onUpdated: _loadUser,
        ),
      ),
    );
  }

  void _deleteUser() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DeleteUserProfileWidget(
          user: {},
          onDeleted: () {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(AppRoutes.splash, (route) => false);
          },
        ),
      ),
    );
  }

  void _logout() async {
    try {
      api.request(
        route: '/auth/logout',
        method: HttpMethod.post,
        body: {'refresh_token': await _auth.refreshToken},
      );
    } catch (e) {
      ErrorHandler.show(context, e);
    }

    await _auth.logout();

    if (!context.mounted) return;

    Navigator.of(context).pushNamedAndRemoveUntil('/', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final loading = _isRefreshing;

    return LoadingOverlay(
      loading: loading,
      child: Column(
        children: [
          if (_cardCode != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CardPlate(
                  title: context.l10n.show_code_to_cassier,
                  barcode: _cardCode!,
                  onExpired: _loadCardCode,
                  key: ValueKey(_cardCodeVersion),
                ),
              ),
            ),

          Expanded(
            child: AdvancedHomePage(
              companies: _companies,
              checks: _checks,
              cards: _cards,
              servicesNotifier: servicesNotifier,
              composePromocodes: _composePromocodes,
              selectedComposePromocodesIndex: _selectedComposePromocodesIndex,
              bonusesNotifier: _bonusesNotifier,
              cardCode: _cardCode,
              cardCodeVersion: _cardCodeVersion,
              user: user,
              onRefresh: _refresh,
              isChecksLoading: _checksLoading,
              onBonuses: _openBonuses,
              onCars: _openCars,
              onNotifications: _openNotifications,
              onSettings: _openSettings,
              onAbout: _openAbout,
              onUpdateUser: _updateUser,
              onDeleteUser: _deleteUser,
              onLogout: _logout,
            ),
          ),
        ],
      ),
    );
  }
}
