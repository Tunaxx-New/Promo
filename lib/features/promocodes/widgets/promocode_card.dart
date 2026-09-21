import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/formatters/form_date.dart';
import 'package:promo/shared/widgets/qr_code_dialog.dart';

class PromocodeCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const PromocodeCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final promocode = data['promocode'] as Map<String, dynamic>? ?? {};

    final company = data['company'] as Map<String, dynamic>? ?? {};

    final userPromocode = data['user_promocode'] as Map<String, dynamic>? ?? {};

    final id = promocode['id']?.toString();
    final title = promocode['title']?.toString() ?? '';
    final description = promocode['description']?.toString() ?? '';
    final code = promocode['code']?.toString() ?? '';

    final companyName = company['name']?.toString() ?? '';

    final discountPercent =
        (promocode['discount_percent'] as num?)?.toInt() ?? 0;

    final discountAmount = (promocode['discount_amount'] as num?)?.toInt() ?? 0;

    final used = userPromocode['is_used'] == true;

    final activatedAt = formatDate(context, userPromocode['activated_at']?.toString());

    final usedAt = formatDate(context, userPromocode['used_at']?.toString());

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (companyName.isNotEmpty)
              Text(companyName, style: theme.textTheme.bodySmall),

            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            if (description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(description),
            ],

            if (code.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  code,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],

            if (discountPercent > 0 || discountAmount > 0) ...[
              const SizedBox(height: 16),

              Wrap(
                spacing: 8,
                children: [
                  if (discountPercent > 0)
                    Chip(label: Text('$discountPercent%')),

                  if (discountAmount > 0)
                    Chip(label: Text('$discountAmount ₸')),
                ],
              ),
            ],

            const SizedBox(height: 12),

            Row(
              children: [
                if (id != null)
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(0, 50),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => QrCodeDialog(
                          id: id,
                          activateOrShare: false,
                          code: code.toString(),
                          title: title.toString(),
                          filePrefix: 'promocode',
                        ),
                      );
                    },
                    icon: const Icon(Icons.share),
                    label: Text(context.l10n.share),
                  ),
                const SizedBox(width: 12),
                if (userPromocode['id'] != null)
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(0, 50),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => QrCodeDialog(
                          id: userPromocode['id'],
                          activateOrShare: true,
                          code: code.toString(),
                          title: title.toString(),
                          filePrefix: 'promocode',
                        ),
                      );
                    },
                    icon: const Icon(Icons.check_circle),
                    label: Text(context.l10n.activate),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            if (activatedAt.isNotEmpty)
              Text(
                '${context.l10n.activated}: $activatedAt',
                style: theme.textTheme.bodySmall,
              ),

            if (used && usedAt.isNotEmpty)
              Text(
                '${context.l10n.used}: $usedAt',
                style: theme.textTheme.bodySmall,
              ),
          ],
        ),
      ),
    );
  }
}
