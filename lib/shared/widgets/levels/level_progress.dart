import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/widgets/levels/level_helpers.dart';
import 'package:promo/shared/widgets/levels/level_state.dart';
import 'package:promo/shared/widgets/levels/levels_list.dart';

/// Полоса прогресса до следующего уровня: «250 / 500» и иконка справа.
class LevelProgress extends StatefulWidget {
  const LevelProgress({
    super.key,
    required this.current,
    this.iconSize,
    this.padding = const EdgeInsets.symmetric(vertical: 4),
    this.border,
  });

  final int current;
  final double? iconSize;
  final EdgeInsets padding;
  final Border? border;

  @override
  State<LevelProgress> createState() => _LevelProgressState();
}

class _LevelProgressState extends State<LevelProgress> {
  bool _expanded = false;

  LoyaltyLevel get _currentLevel {
    return getCurrentLevel(widget.current);
  }

  LoyaltyLevel? get _nextLevel {
    return getNextLevel(_currentLevel);
  }

  double get _progress {
    final nextLevel = _nextLevel;

    // Максимальный уровень уже достигнут.
    if (nextLevel == null) {
      return 1.0;
    }

    final currentRequired = _currentLevel.requiredBonuses;
    final nextRequired = nextLevel.requiredBonuses;

    final range = nextRequired - currentRequired;

    if (range <= 0) {
      return 1.0;
    }

    final progress = (widget.current - currentRequired) / range;

    return progress.clamp(0.0, 1.0);
  }

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProgressHeader(
          current: widget.current,
          currentLevel: _currentLevel,
          nextLevel: _nextLevel,
          progress: _progress,
          expanded: _expanded,
          onTap: _toggleExpanded,
          iconSize: widget.iconSize,
          padding: widget.padding,
          border: widget.border,
        ),

        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: _expanded
              ? LevelsList(current: widget.current)
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader({
    required this.current,
    required this.currentLevel,
    required this.nextLevel,
    required this.progress,
    required this.expanded,
    required this.onTap,
    this.iconSize,
    required this.padding,
    this.border,
  });

  final int current;
  final LoyaltyLevel currentLevel;
  final LoyaltyLevel? nextLevel;
  final double progress;
  final bool expanded;
  final VoidCallback onTap;
  final double? iconSize;
  final EdgeInsets padding;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    final target = nextLevel?.requiredBonuses;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: iconSize ?? 22,
                  height: iconSize ?? 22,
                  child: currentLevel.icon,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    getLevelTitle(context, currentLevel.name),
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Icon(
                  expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: AppColors.textSecondary,
                  size: 22,
                ),
              ],
            ),

            const SizedBox(height: 10),

            // PROGRESS
            SizedBox(
              width: double.infinity,
              child: Container(
                height: 18,
                decoration: BoxDecoration(
                  color: AppColors.backgroundTop,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.backgroundTop.withValues(alpha: 0.25),
                    width: 1,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    // Заполненная часть
                    FractionallySizedBox(
                      widthFactor: progress,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              currentLevel.color.withValues(alpha: 0.75),
                              currentLevel.color,
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Текст поверх всего progress bar
                    Positioned.fill(
                      child: Center(
                        child: Text(
                          target == null ? '$current' : '$current / $target',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (nextLevel != null) ...[
              const SizedBox(height: 5),

              Text(
                context.l10n.until_next_level(
                  getLevelTitle(context, nextLevel!.name),
                ),
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
