import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/formatters/form_card_id.dart';
import 'package:promo/shared/models/user_card.dart';

class CardCard extends StatelessWidget {
  final UserCard card;

  const CardCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.credit_card_outlined),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    formatCardId(card.cardId),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Text(
                    '${card.discountPercent}%',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.card_giftcard),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${card.bonusesSum}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            if (card.company != null) ...[
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 14),

              Text(
                context.l10n.companyTitle,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 5),
              Text(
                card.company!.name,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              Text(
                'БИН: ${card.company!.bin}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 3),
              Text(
                card.company!.address.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],

            const SizedBox(height: 20),
            const Divider(),

            Center(
              child: BarcodeWidget(
                barcode: Barcode.code128(),
                padding: const EdgeInsets.all(16),
                data: card.cardId,
                width: double.infinity,
                height: 120,
                drawText: true,
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
