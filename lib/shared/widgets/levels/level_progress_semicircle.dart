import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/widgets/levels/level_helpers.dart';
import 'package:promo/shared/widgets/levels/level_state.dart';
import 'package:promo/shared/widgets/levels/levels_list.dart';

class LevelProgressCircle extends StatefulWidget {
  const LevelProgressCircle({super.key, required this.current});

  final int current;

  @override
  State<LevelProgressCircle> createState() => _LevelProgressCircleState();
}

class _LevelProgressCircleState extends State<LevelProgressCircle> {
  bool _expanded = false;

  LoyaltyLevel get _currentLevel {
    return getCurrentLevel(widget.current);
  }

  LoyaltyLevel? get _nextLevel {
    return getNextLevel(_currentLevel);
  }

  double get _progress {
    final nextLevel = _nextLevel;

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
        InkWell(
          onTap: _toggleExpanded,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                _CircularLevelIndicator(
                  level: _currentLevel,
                  progress: _progress,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getLevelTitle(context, _currentLevel.name),
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 4),

                      if (_nextLevel != null)
                        Text(
                          context.l10n.until_next_level(
                            getLevelTitle(context, _nextLevel!.name),
                          ),
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                          ),
                        ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _nextLevel == null
                          ? '${widget.current}'
                          : '${widget.current} / ${_nextLevel!.requiredBonuses}',
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Icon(
                      _expanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
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

class _CircularLevelIndicator extends StatelessWidget {
  const _CircularLevelIndicator({required this.level, required this.progress});

  final LoyaltyLevel level;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58,
      height: 58,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle
          SizedBox(
            width: 58,
            height: 58,
            child: CircularProgressIndicator(
              value: 1,
              strokeWidth: 5,
              color: AppColors.backgroundTop,
            ),
          ),

          // Progress
          SizedBox(
            width: 58,
            height: 58,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 5,
              strokeCap: StrokeCap.round,
              color: level.color,
            ),
          ),

          // Level icon
          SizedBox(width: 30, height: 30, child: level.icon),
        ],
      ),
    );
  }
}
