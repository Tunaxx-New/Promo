import 'package:flutter/material.dart';
import 'package:promo/core/api/minio.dart';
import 'package:promo/features/cards/cards_page.dart';
import 'package:promo/features/home/widgets/app_bottom_navigation.dart';
import 'package:promo/features/home/widgets/home_header.dart';
import 'package:promo/features/map/map_page.dart';
import 'package:promo/features/profile/profile_page.dart';
import 'package:promo/features/weather/pages/weather_screen.dart';
import 'package:promo/pages/ads_screen.dart';
import 'package:promo/pages/bonuses_screen.dart';
import 'package:promo/pages/news_screen.dart';
import 'package:promo/pages/post_screen.dart';
import 'package:promo/shared/extensions/extract_max_discount.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/models/company.dart';
import 'package:promo/shared/models/payment_check.dart';
import 'package:promo/shared/models/promotion.dart';
import 'package:promo/shared/models/service.dart';
import 'package:promo/shared/models/user.dart';
import 'package:promo/shared/models/user_card.dart';
import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/theme/app_strings.dart';
import 'package:promo/shared/theme/app_theme.dart';
import 'package:promo/shared/widgets/authorization/authorization_service.dart';
import 'package:promo/shared/widgets/bonuses/bonus_card.dart';
import 'package:promo/shared/widgets/bonuses/bonuses_details.dart';
import 'package:promo/shared/widgets/menus/grid_menu/menu_grid.dart';
import 'package:promo/shared/widgets/menus/grid_menu/menu_item.dart';
import 'package:promo/shared/widgets/paginated_list.dart';
import 'package:promo/shared/widgets/promotions/promo_banner.dart';
import 'package:promo/shared/widgets/promotions/promotions_service.dart';
import 'package:promo/shared/widgets/services/advanced_service_list.dart';
import 'package:promo/shared/widgets/services/service_list.dart';
import 'package:promo/shared/widgets/user/user_service.dart';

/// Главный экран. Сам по себе ничего не рисует — только собирает
/// виджеты из lib/widgets и раздаёт им данные и обработчики.
class AdvancedHomePage extends StatefulWidget {
  final List<Company> companies;
  final List<PaymentCheck> checks;
  final List<UserCard> cards;
  final ValueNotifier<List<Service>> servicesNotifier;
  final List<dynamic> composePromocodes;
  final int selectedComposePromocodesIndex;
  final ValueNotifier<double> bonusesNotifier;
  final String? cardCode;
  final int cardCodeVersion;
  final User? user;

  final Future<void> Function()? onRefresh;

  final VoidCallback onBonuses;
  final VoidCallback onCars;
  final VoidCallback onNotifications;
  final VoidCallback onSettings;
  final VoidCallback onAbout;
  final VoidCallback onUpdateUser;
  final VoidCallback onDeleteUser;
  final VoidCallback onLogout;

  // Loadings
  final bool isChecksLoading;

  const AdvancedHomePage({
    super.key,
    required this.companies,
    required this.checks,
    required this.cards,
    required this.servicesNotifier,
    required this.composePromocodes,
    required this.selectedComposePromocodesIndex,
    required this.bonusesNotifier,
    required this.cardCode,
    required this.cardCodeVersion,
    required this.user,
    this.onRefresh,
    required this.onBonuses,
    required this.onCars,
    required this.onNotifications,
    required this.onSettings,
    required this.onAbout,
    required this.onUpdateUser,
    required this.onDeleteUser,
    required this.onLogout,
    required this.isChecksLoading,
  });

  @override
  State<AdvancedHomePage> createState() => _AdvancedHomePageState();
}

class _AdvancedHomePageState extends State<AdvancedHomePage> {
  // Company feature values
  int _selectedCompanyIndex = 0;

  // Promocode feature values
  String? _activatedPromocodeId;

  // Navigation and utils
  int? _navIndex = 0;

  // Main navigation with navigation menu in bottom
  bool _isAdsPage = false;
  bool _isNewsPage = false;
  bool _isWeatherPage = false;

  // First priority news
  late final PublicPromotionService _service;
  PromotionTag? _selectedTag;

  @override
  void initState() {
    super.initState();
    _service = PublicPromotionService(minio: MinioStorage());
  }

  void hideAllUnnavigatedPages() {
    _isAdsPage = false;
    _isNewsPage = false;
    _isWeatherPage = false;
  }

  void _openSection(MenuItem item) {
    setState(() {
      hideAllUnnavigatedPages();
    });

    switch (item.id) {
      case 'bonuses':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BonusesPage(
              balance: widget.bonusesNotifier,
              onSpend: _spendBonuses,
              widgetListServices: AdvancedServiceList(servicesNotifier: widget.servicesNotifier)
            ),
          ),
        );
        break;

      case 'ads':
        setState(() {
          _navIndex = null;
          _isAdsPage = true;
          _selectedTag = null;
        });
        break;

      case 'offers':
        setState(() {
          _navIndex = null;
          _isAdsPage = true;
          _selectedTag = PromotionTag.promotion;
        });
        break;

      case 'news':
        setState(() {
          _navIndex = null;
          _isNewsPage = true;
        });

      case 'wash':
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                '${context.l10n.washing} ${context.l10n.is_not_available_yet}',
                style: TextStyle(fontSize: 18),
              ),
            );
          },
        );

      case 'weather':
        setState(() {
          _navIndex = null;
          _isWeatherPage = true;
        });
    }
  }

  void _spendBonuses() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CardsPage(
          cards: widget.cards,
          isLoading: widget.isChecksLoading,
          showAppBar: true,
        ),
      ),
    );
  }

  Widget _buildPage() {
    if (_isAdsPage) {
      return AdsPage(selectedTag: _selectedTag, companies: widget.companies);
    }

    if (_isNewsPage) {
      return NewsPage(companies: widget.companies);
    }

    if (_isWeatherPage) {
      return const WeatherPage();
    }

    if (_navIndex == 1) {
      return BonusesDetails(
        checks: widget.checks,
        appBarBackgroundColor: Theme.of(context).colorScheme.surface,
        isBackButton: false,
      );
    }

    if (_navIndex == 2) {
      return MapPage();
    }

    if (_navIndex == 3) {
      return ProfilePage(
        userName: widget.user?.name,
        userPhone: widget.user?.phone,
        balance: widget.bonusesNotifier,
        onBonuses: () => {
          widget.onBonuses(),
          _openSection(
            MenuItem.bonuses(context, Theme.of(context).colorScheme),
          ),
        },
        onCars: widget.onCars,
        onNotifications: widget.onNotifications,
        onSettings: widget.onSettings,
        onAbout: widget.onAbout,
        onUpdateUser: widget.onUpdateUser,
        onDeleteUser: widget.onDeleteUser,
        onLogout: widget.onLogout,
      );
    }

    return Column(
      children: [
        Expanded(
          flex: 3,
          child: RefreshIndicator(
            onRefresh: widget.onRefresh ?? () async {},
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppTheme.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_navIndex == 0) ...[
                    const SizedBox(height: 8),

                    HomeHeader(
                      userName: widget.user?.name ?? context.l10n.guest,
                      onProfileTap: () => setState(() => _navIndex = 3),
                    ),

                    const SizedBox(height: 18),

                    BonusCard(
                      balance: widget.bonusesNotifier.value.toInt(),
                      title: context.l10n.your_bonuses,
                      isLoading: widget.isChecksLoading,
                      onSpend: _spendBonuses,
                    ),

                    const SizedBox(height: 16),

                    MenuGrid(onItemTap: _openSection),

                    const SizedBox(height: 16),

                    PaginatedList<Promotion>(
                      isOnce: true,
                      scrollable: false,
                      key: ValueKey(null),
                      pageSize: 1,
                      loadPage: (page, limit) async {
                        final promotions = await _service.getPromotions(
                          page: page,
                          limit: limit,
                          tag: null,
                        );

                        return promotions.map((item) {
                          final company = widget.companies
                              .cast<Company?>()
                              .firstWhere(
                                (company) => company?.id == item.companyId,
                                orElse: () => null,
                              );

                          item.companyName =
                              company?.name ?? AppStrings.companyName;
                          return item;
                        }).toList();
                      },
                      emptyWidget: Padding(
                        padding: const EdgeInsets.only(top: 200),
                        child: Center(child: Text(context.l10n.no_promotions)),
                      ),
                      itemBuilder: (context, promotion) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: PromoBanner(
                            title: promotion.title,
                            discountLabel: extractMaxDiscount(promotion.title),
                            imageUrl: promotion.imageUrl,
                            tagValue: promotion.tag != null
                                ? promotionTagLabel(context, promotion.tag!)
                                : null,
                            tagColor: promotion.tag?.color,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => PostPage(
                                    id: promotion.id,
                                    title: promotion.title,
                                    description: promotion.description,
                                    tag: promotionTagLabel(
                                      context,
                                      promotion.tag,
                                    ),
                                    tagColor: promotion.tag?.color,
                                    priority: promotion.priority,
                                    createdAt: promotion.createdAt,
                                    companyId: promotion.companyId,
                                    companyName: promotion.companyName,
                                    imageUrl: promotion.imageUrl,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppColors.screenGradient),
        child: SafeArea(bottom: false, child: _buildPage()),
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _navIndex,
        onTap: (index) => setState(() {
          _navIndex = index;
          hideAllUnnavigatedPages();
        }),
      ),
    );
  }
}
