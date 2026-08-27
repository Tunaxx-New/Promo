import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';

class BonusesPlate extends StatelessWidget {
  final double bonusSum;
  final String? imageUrl;
  final VoidCallback? onTap;
  final VoidCallback? onUpdate;

  const BonusesPlate({
    super.key,
    required this.bonusSum,
    this.imageUrl,
    this.onTap,
    this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: colorScheme.primary,
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceBright,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Text(
                            bonusSum.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0+$'), ''),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'B',
                            style: TextStyle(
                              color: colorScheme.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl!,
                    width: 64,
                    height: 44,
                    fit: BoxFit.fitWidth,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}