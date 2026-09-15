import 'package:flutter/material.dart';
import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/theme/app_theme.dart';
import 'package:promo/shared/widgets/menus/grid_menu/menu_item.dart';


/// Одна плитка быстрого действия: иконка сверху, подпись снизу.
class MenuTile extends StatelessWidget {
  const MenuTile({
    super.key,
    required this.item,
    this.onTap,
  });

  final MenuItem item;
  final ValueChanged<MenuItem>? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: AppTheme.tileRadius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap == null ? null : () => onTap!(item),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: AppTheme.tileRadius,
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, size: 30, color: item.iconColor),
              const SizedBox(height: 10),
              Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
