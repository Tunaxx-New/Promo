import 'dart:async';

import 'package:flutter/material.dart';
import 'package:promo/core/api/api.dart';
import 'package:promo/features/home/advanced_home_page.dart';

import 'package:promo/shared/models/company.dart';
import 'package:promo/shared/models/payment_check.dart';
import 'package:promo/shared/models/user_card.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';
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

  String? _username;

  bool? _isCompany;
  List<Company> _companies = [];
  final List<PaymentCheck> _checks = [];
  final List<UserCard> _cards = [];

  List<dynamic> _composePromocodes = [];
  int _selectedComposePromocodesIndex = 0;

  double _bonuses = 0.0;

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
        _username = response['name'];
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

    return LoadingOverlay(
      loading: loading,
      child: AdvancedHomePage(
        companies: _companies,
        checks: _checks,
        cards: _cards,
        composePromocodes: _composePromocodes,
        selectedComposePromocodesIndex: _selectedComposePromocodesIndex,
        bonuses: _bonuses,
        cardCode: _cardCode,
        cardCodeVersion: _cardCodeVersion,
        username: _username,
        onRefresh: _refresh,
      ),
    );
  }
}
