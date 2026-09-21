import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/theme/app_theme.dart';
import 'package:promo/shared/widgets/bonuses/coin_icon.dart';
import 'package:promo/shared/widgets/bonuses/spend_button.dart';
import 'package:promo/shared/widgets/levels/level_progress.dart';
import 'package:promo/shared/widgets/card/glass_card.dart';

/// Карточка баланса: монета, количество бонусов, кнопка «Потратить»
/// и прогресс до следующего уровня.
class BonusCard extends StatelessWidget {
  const BonusCard({
    super.key,
    required this.balance,
    required this.title,
    required this.isLoading,
    this.onSpend,
  });

  final int balance;
  final String title;
  final bool isLoading;
  final VoidCallback? onSpend;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const CoinIcon(),
              const SizedBox(width: 10),
              Expanded(
                child: isLoading
                    ? const Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: 28,
                          height: 28,
                          child: CircularProgressIndicator(strokeWidth: 3),
                        ),
                      )
                    : Text(
                        '$balance',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ),
              ),
              SpendButton(onTap: onSpend),
            ],
          ),
          const SizedBox(height: 18),
          LevelProgress(current: balance),
        ],
      ),
    );
  }
}
