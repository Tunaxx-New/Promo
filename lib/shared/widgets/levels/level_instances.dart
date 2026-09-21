import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/widgets/levels/level_state.dart';

class LoyaltyLevels {
  static List<LoyaltyLevel> all = [
    LoyaltyLevel(
      name: LoyaltyLevelName.bronze,
      requiredBonuses: 0,
      icon: SvgPicture.asset('assets/icons/medal-bronze.svg'),
      color: AppColors.bronze,
    ),
    LoyaltyLevel(
      name: LoyaltyLevelName.silver,
      requiredBonuses: 1000,
      icon: SvgPicture.asset('assets/icons/medal-silver.svg'),
      color: AppColors.silver,
    ),
    LoyaltyLevel(
      name: LoyaltyLevelName.gold,
      requiredBonuses: 10000,
      icon: SvgPicture.asset('assets/icons/crown.svg'),
      color: AppColors.gold,
    ),
    LoyaltyLevel(
      name: LoyaltyLevelName.diamond,
      requiredBonuses: 50000,
      icon: SvgPicture.asset('assets/icons/diamond.svg'),
      color: AppColors.diamond,
    ),
  ];
}
