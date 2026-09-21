import 'package:flutter/material.dart';

enum LoyaltyLevelName { bronze, silver, gold, diamond }

enum LevelState { locked, current, completed }

class LoyaltyLevel {
  const LoyaltyLevel({
    required this.name,
    required this.requiredBonuses,
    required this.icon,
    required this.color,
  });

  final LoyaltyLevelName name;
  final int requiredBonuses;
  final Widget icon;
  final Color color;
}
