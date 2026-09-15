import 'package:flutter/material.dart';
import 'package:promo/features/home/widgets/app_bottom_navigation.dart';
import 'package:promo/features/home/widgets/home_header.dart';
import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/theme/app_theme.dart';
import 'package:promo/shared/widgets/bonuses/bonus_card.dart';
import 'package:promo/shared/widgets/menus/grid_menu/menu_grid.dart';
import 'package:promo/shared/widgets/menus/grid_menu/menu_item.dart';
import 'package:promo/shared/widgets/promotions/promo_banner.dart';


/// Главный экран. Сам по себе ничего не рисует — только собирает
/// виджеты из lib/widgets и раздаёт им данные и обработчики.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;

  void _openSection(MenuItem item) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('Открыть раздел «${item.label}»')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppColors.screenGradient),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: AppTheme.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                HomeHeader(
                  userName: 'Максим',
                  onProfileTap: () => setState(() => _navIndex = 3),
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
        ),
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _navIndex,
        onTap: (index) => setState(() => _navIndex = index),
      ),
    );
  }
}
