import 'package:flutter/material.dart';
import 'package:promo/shared/widgets/levels/level_helpers.dart';
import 'package:promo/shared/widgets/levels/level_instances.dart';
import 'package:promo/shared/widgets/levels/level_item.dart';

class LevelsList extends StatelessWidget {
  const LevelsList({required this.current});

  final int current;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        children: [
          for (var i = 0; i < LoyaltyLevels.all.length; i++)
            Padding(
              padding: EdgeInsets.only(
                bottom: i == LoyaltyLevels.all.length - 1 ? 0 : 8,
              ),
              child: LevelItem(
                level: LoyaltyLevels.all[i],
                state: getLevelState(LoyaltyLevels.all[i], current),
              ),
            ),
        ],
      ),
    );
  }
}
