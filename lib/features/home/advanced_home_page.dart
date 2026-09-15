import 'package:flutter/material.dart';
import 'package:promo/core/api/minio.dart';
import 'package:promo/features/home/widgets/app_bottom_navigation.dart';
import 'package:promo/features/home/widgets/home_header.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/models/company.dart';
import 'package:promo/shared/models/payment_check.dart';
import 'package:promo/shared/models/user_card.dart';
import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/theme/app_theme.dart';
import 'package:promo/shared/widgets/authorization/authorization_service.dart';
import 'package:promo/shared/widgets/bonuses/bonus_card.dart';
import 'package:promo/shared/widgets/menus/grid_menu/menu_grid.dart';
import 'package:promo/shared/widgets/menus/grid_menu/menu_item.dart';
import 'package:promo/shared/widgets/promotions/promo_banner.dart';
import 'package:promo/shared/widgets/user/user_service.dart';

/// Главный экран. Сам по себе ничего не рисует — только собирает
/// виджеты из lib/widgets и раздаёт им данные и обработчики.
class AdvancedHomePage extends StatefulWidget {
  final List<Company> companies;
  final List<PaymentCheck> checks;
  final List<UserCard> cards;
  final List<dynamic> composePromocodes;
  final int selectedComposePromocodesIndex;
  final double bonuses;
  final String? cardCode;
  final int cardCodeVersion;
  final String? username;
  final Future<void> Function()? onRefresh;

  const AdvancedHomePage({
    super.key,
    required this.companies,
    required this.checks,
    required this.cards,
    required this.composePromocodes,
    required this.selectedComposePromocodesIndex,
    required this.bonuses,
    required this.cardCode,
    required this.cardCodeVersion,
    required this.username,
    this.onRefresh,
  });

  @override
  State<AdvancedHomePage> createState() => _AdvancedHomePageState();
}

class _AdvancedHomePageState extends State<AdvancedHomePage> {
  final _auth = AuthorizationService();
  final _minio = MinioStorage();

  // Company feature values
  int _selectedCompanyIndex = 0;

  // Promocode feature values
  String? _activatedPromocodeId;

  // Navigation and utils
  int _navIndex = 0;

  void _openSection(MenuItem item) {
    print(item.label);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppColors.screenGradient),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: widget.onRefresh ?? () async {},
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          padding: AppTheme.screenPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 8),
                              HomeHeader(
                                userName: widget.username ?? context.l10n.guest,
                                onProfileTap: () =>
                                    setState(() => _navIndex = 3),
                              ),
                              const SizedBox(height: 18),
                              BonusCard(
                                balance: 250,
                                levelTarget: 500,
                                onSpend: () {},
                              ),
                              const SizedBox(height: 16),
                              MenuGrid(onItemTap: _openSection),
                              const SizedBox(height: 16),
                              PromoBanner(
                                title: 'Сегодня скидка\nна комплексную мойку',
                                discountLabel: '-20%',
                                onTap: () {},
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _navIndex,
        onTap: (index) => setState(() => _navIndex = index),
      ),
    );
  }
}
