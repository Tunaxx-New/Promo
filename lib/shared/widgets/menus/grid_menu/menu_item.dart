import 'package:flutter/material.dart';
import 'package:promo/shared/theme/app_colors.dart';


/// Описание одной плитки в сетке быстрых действий.
@immutable
class MenuItem {
  const MenuItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.iconColor,
  });

  final String id;
  final String label;
  final IconData icon;
  final Color iconColor;

  /// Набор по умолчанию — как на макете.
  static List<MenuItem> defaults(ColorScheme colorScheme) => <MenuItem>[
    MenuItem(
      id: 'wash',
      label: 'Мойка',
      icon: Icons.local_car_wash,
      iconColor: colorScheme.secondary,
    ),
    MenuItem(
      id: 'bonuses',
      label: 'Бонусы',
      icon: Icons.card_giftcard,
      iconColor: AppColors.textPrimary,
    ),
    MenuItem(
      id: 'offers',
      label: 'Акции',
      icon: Icons.percent,
      iconColor: AppColors.danger,
    ),
    MenuItem(
      id: 'ads',
      label: 'Реклама',
      icon: Icons.campaign,
      iconColor: AppColors.accent,
    ),
    MenuItem(
      id: 'weather',
      label: 'Погода',
      icon: Icons.wb_sunny,
      iconColor: AppColors.gold,
    ),
    MenuItem(
      id: 'news',
      label: 'Новости',
      icon: Icons.article,
      iconColor: AppColors.accent,
    ),
  ];
}
