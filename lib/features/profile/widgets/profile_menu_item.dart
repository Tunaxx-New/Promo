import 'package:flutter/material.dart';

import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/theme/app_theme.dart';

/// Строка меню профиля: иконка слева, заголовок и стрелка справа.
class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.isFirst = false,
    this.isLast = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final itemIconColor = iconColor ?? colorScheme.onSurface;

    final borderRadius = BorderRadius.only(
      topLeft: isFirst ? AppTheme.cardRadius.topLeft : Radius.zero,
      topRight: isFirst ? AppTheme.cardRadius.topRight : Radius.zero,
      bottomLeft: isLast ? AppTheme.cardRadius.bottomLeft : Radius.zero,
      bottomRight: isLast ? AppTheme.cardRadius.bottomRight : Radius.zero,
    );

    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [colorScheme.surfaceContainerHighest, colorScheme.surface],
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Row(
                  children: [
                    Icon(icon, size: 22, color: itemIconColor),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 22,
                      color: colorScheme.onSurface,
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  height: 1,
                  color: AppColors.border,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
