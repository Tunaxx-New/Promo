import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:promo/features/home/widgets/home_header.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/theme/app_strings.dart';
import 'package:promo/shared/widgets/bonuses/coin_icon.dart';
import 'package:promo/shared/widgets/bonuses/spend_button.dart';
import 'package:promo/shared/widgets/levels/level_progress.dart';
import 'package:promo/shared/widgets/levels/level_progress_semicircle_simple.dart';
import 'package:promo/shared/widgets/services/advanced_service_list.dart';
import 'package:promo/shared/widgets/services/service_list.dart';

class BonusesPage extends StatelessWidget {
  const BonusesPage({super.key, required this.balance, required this.onSpend, required this.widgetListServices});

  final ValueListenable<double> balance;
  final VoidCallback? onSpend;
  final Widget widgetListServices;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: balance,
      builder: (context, balance, _) {
        return Scaffold(
          body: DecoratedBox(
            decoration: const BoxDecoration(gradient: AppColors.screenGradient),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          context.l10n.bonuses,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 216,
                      height: 160,
                      child: ClipRect(
                        child: OverflowBox(
                          alignment: Alignment.topCenter,
                          minWidth: 216,
                          maxWidth: 216,
                          minHeight: 216,
                          maxHeight: 216,
                          child: LevelProgressCircleSimple(
                            size: 200,
                            startAngle: 180,
                            current: balance.toInt(),
                            center: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const CoinIcon(),
                                const SizedBox(height: 4),
                                Text(
                                  balance.toInt().toString(),
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Center(
                    child: SizedBox(
                      width: 180,
                      child: SpendButton(onTap: onSpend),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Expanded(child: widgetListServices),

                  const SizedBox(height: 24),

                  LevelProgress(current: balance.toInt(), iconSize: 60.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
