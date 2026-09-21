import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/widgets/levels/level_instances.dart';
import 'package:promo/shared/widgets/levels/level_state.dart';

LoyaltyLevel getCurrentLevel(int bonuses) {
  LoyaltyLevel current = LoyaltyLevels.all.first;

  for (final level in LoyaltyLevels.all) {
    if (bonuses >= level.requiredBonuses) {
      current = level;
    } else {
      break;
    }
  }

  return current;
}

LoyaltyLevel? getNextLevel(LoyaltyLevel currentLevel) {
  final index = LoyaltyLevels.all.indexOf(currentLevel);

  if (index == -1 || index >= LoyaltyLevels.all.length - 1) {
    return null;
  }

  return LoyaltyLevels.all[index + 1];
}

LevelState getLevelState(LoyaltyLevel level, int bonuses) {
  if (bonuses >= level.requiredBonuses) {
    return LevelState.completed;
  }

  final currentLevel = getCurrentLevel(bonuses);

  if (level == currentLevel) {
    return LevelState.current;
  }

  return LevelState.locked;
}

String getLevelTitle(BuildContext context, LoyaltyLevelName name) {
  final l10n = context.l10n;

  return switch (name) {
    LoyaltyLevelName.bronze => l10n.bronze,
    LoyaltyLevelName.silver => l10n.silver,
    LoyaltyLevelName.gold => l10n.gold,
    LoyaltyLevelName.diamond => l10n.diamond,
  };
}
