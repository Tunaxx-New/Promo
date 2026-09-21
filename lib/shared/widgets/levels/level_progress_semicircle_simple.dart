import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/widgets/levels/level_helpers.dart';
import 'package:promo/shared/widgets/levels/level_state.dart';

class LevelProgressCircleSimple extends StatelessWidget {
  const LevelProgressCircleSimple({
    super.key,
    required this.current,
    this.center,
    this.size = 72,
    this.strokeWidth = 6,
    this.startAngle = 0,
  });

  final int current;
  final Widget? center;

  final double size;
  final double strokeWidth;

  /// Start angle in degrees.
  ///
  /// 0   = 12 o'clock
  /// 90  = 3 o'clock
  /// 180 = 6 o'clock
  /// 270 = 9 o'clock
  final double startAngle;

  LoyaltyLevel get _currentLevel {
    return getCurrentLevel(current);
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

    return ((current - currentRequired) / range).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final angle = startAngle * math.pi / 180;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.rotate(
            angle: angle,
            child: SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                value: 1,
                strokeWidth: strokeWidth,
                valueColor: AlwaysStoppedAnimation(AppColors.backgroundTop),
              ),
            ),
          ),

          Transform.rotate(
            angle: angle,
            child: SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                value: _progress,
                strokeWidth: strokeWidth,
                strokeCap: StrokeCap.round,
                valueColor: AlwaysStoppedAnimation(_currentLevel.color),
              ),
            ),
          ),

          center ?? _currentLevel.icon,
        ],
      ),
    );
  }
}
