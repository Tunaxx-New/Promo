import 'package:flutter/material.dart';
import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/theme/app_theme.dart';
import 'package:promo/shared/widgets/bonuses/level_progress.dart';
import 'package:promo/shared/widgets/card/glass_card.dart';


/// Карточка баланса: монета, количество бонусов, кнопка «Потратить»
/// и прогресс до следующего уровня.
class BonusCard extends StatelessWidget {
  const BonusCard({
    super.key,
    required this.balance,
    required this.levelTarget,
    this.title = 'Ваши бонусы',
    this.onSpend,
  });

  final int balance;
  final int levelTarget;
  final String title;
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
              const _CoinIcon(),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
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
              _SpendButton(onTap: onSpend),
            ],
          ),
          const SizedBox(height: 18),
          LevelProgress(current: balance, target: levelTarget),
        ],
      ),
    );
  }
}

class _CoinIcon extends StatelessWidget {
  const _CoinIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFD75E), Color(0xFFE0A100)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withOpacity(0.35),
            blurRadius: 14,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Text(
        '\u20B8',
        style: TextStyle(
          color: Color(0xFF7A5200),
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _SpendButton extends StatelessWidget {
  const _SpendButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: AppTheme.pillRadius,
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      child: Ink(
        decoration: const BoxDecoration(
          gradient: AppColors.accentGradient,
          borderRadius: AppTheme.pillRadius,
        ),
        child: InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 11),
            child: Text(
              'Потратить',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
