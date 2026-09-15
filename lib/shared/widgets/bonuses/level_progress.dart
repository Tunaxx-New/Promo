import 'package:flutter/material.dart';
import 'package:promo/shared/theme/app_colors.dart';


/// Полоса прогресса до следующего уровня: «250 / 500» и корона справа.
class LevelProgress extends StatelessWidget {
  const LevelProgress({
    super.key,
    required this.current,
    required this.target,
    this.title = 'До следующего уровня',
  });

  final int current;
  final int target;
  final String title;

  double get _fraction {
    if (target <= 0) return 0;
    return (current / target).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ),
            const Icon(Icons.emoji_events, color: AppColors.gold, size: 22),
          ],
        ),
        const SizedBox(height: 10),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: SizedBox(
                height: 18,
                child: Stack(
                  children: [
                    const ColoredBox(
                      color: AppColors.surfaceLight,
                      child: SizedBox.expand(),
                    ),
                    FractionallySizedBox(
                      widthFactor: _fraction,
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: AppColors.accentGradient,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                '$current / $target',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
