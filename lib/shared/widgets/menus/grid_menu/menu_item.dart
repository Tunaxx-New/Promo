import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
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
  static List<MenuItem> defaults(
    ColorScheme colorScheme,
    BuildContext context,
  ) => <MenuItem>[
    MenuItem(
      id: 'wash',
      label: context.l10n.washing,
      icon: Icons.local_car_wash,
      iconColor: colorScheme.secondary,
    ),
    MenuItem(
      id: 'bonuses',
      label: context.l10n.bonuses,
      icon: Icons.card_giftcard,
      iconColor: AppColors.textPrimary,
    ),
    MenuItem(
      id: 'offers',
      label: context.l10n.promotions,
      icon: Icons.percent,
      iconColor: AppColors.danger,
    ),
    MenuItem(
      id: 'ads',
      label: context.l10n.ads,
      icon: Icons.campaign,
      iconColor: AppColors.accent,
    ),
    MenuItem(
      id: 'weather',
      label: context.l10n.weather,
      icon: Icons.wb_sunny,
      iconColor: AppColors.gold,
    ),
    MenuItem(
      id: 'news',
      label: context.l10n.news,
      icon: Icons.article,
      iconColor: AppColors.accent,
    ),
  ];

  static MenuItem bonuses(BuildContext context, ColorScheme colorScheme) {
    return MenuItem(
      id: 'bonuses',
      label: context.l10n.bonuses,
      icon: Icons.card_giftcard,
      iconColor: AppColors.textPrimary,
    );
  }
}
