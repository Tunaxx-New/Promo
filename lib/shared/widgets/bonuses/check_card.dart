import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/formatters/form_date.dart';
import 'package:promo/shared/formatters/form_money.dart';
import 'package:promo/shared/models/payment_check.dart';
import 'package:promo/shared/theme/app_strings.dart';
import 'package:promo/shared/widgets/bonuses/coin_icon.dart';

class PaymentCheckCard extends StatelessWidget {
  final PaymentCheck check;
  final VoidCallback onTap;

  const PaymentCheckCard({super.key, required this.check, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bonusColor = check.bonusSum > 0
        ? Theme.of(context).colorScheme.onSurface
        : check.bonusSum < 0
        ? Colors.red
        : null;

    final bonusText = check.bonusSum > 0
        ? '+${check.bonusSum}'
        : check.bonusSum.toString();

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.1),
                ),
                child: Icon(
                  Icons.receipt_long_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.companyName,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatDate(context, check.processedAt.toString()),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${formatMoney(check.sum)} ₸',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        bonusText,
                        style: TextStyle(
                          color: bonusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const CoinIcon(width: 24, height: 24, fontSize: 16,),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
