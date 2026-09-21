import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/widgets/levels/level_helpers.dart';
import 'package:promo/shared/widgets/levels/level_state.dart';

class LevelItem extends StatelessWidget {
  const LevelItem({required this.level, required this.state});

  final LoyaltyLevel level;
  final LevelState state;

  @override
  Widget build(BuildContext context) {
    final isCurrent = state == LevelState.current;
    final isCompleted = state == LevelState.completed;
    final isLocked = state == LevelState.locked;

    return Opacity(
      opacity: isLocked ? 0.45 : 1.0,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isCurrent
              ? level.color.withValues(alpha: 0.10)
              : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(12),
          border: isCurrent
              ? Border.all(color: level.color.withValues(alpha: 0.5))
              : null,
        ),
        child: Row(
          children: [
            SizedBox(width: 26, height: 26, child: level.icon),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getLevelTitle(context, level.name),
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    '${level.requiredBonuses} ${context.l10n.bonuses}',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            if (isCompleted) SizedBox(width: 21, height: 21, child: level.icon),

            if (isCurrent)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: level.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  context.l10n.current,
                  style: TextStyle(
                    color: level.color,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            if (isLocked)
              const Icon(
                Icons.lock_outline,
                color: AppColors.textSecondary,
                size: 18,
              ),
          ],
        ),
      ),
    );
  }
}
