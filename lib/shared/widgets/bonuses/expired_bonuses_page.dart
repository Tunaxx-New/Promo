import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/models/payment_check.dart';

class ExpiredBonusesPage extends StatelessWidget {
  final List<PaymentCheck> checks;

  const ExpiredBonusesPage({
    super.key,
    required this.checks,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final bonusChecks = checks
        .where((check) => check.bonusSum > 0)
        .map((check) {
          final expirationDate = DateTime(
            check.processedAt.year + 1,
            check.processedAt.month,
            check.processedAt.day,
          );

          return (
            check: check,
            expirationDate: expirationDate,
          );
        })
        .toList();

    // Show the closest expiration first.
    bonusChecks.sort(
      (a, b) => a.expirationDate.compareTo(b.expirationDate),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.bonuses),
      ),
      body: bonusChecks.isEmpty
          ? Center(
              child: Text('${context.l10n.no} ${context.l10n.bonusov}'),
            )
          : ListView.builder(
              itemCount: bonusChecks.length,
              itemBuilder: (context, index) {
                final item = bonusChecks[index];
                final check = item.check;
                final expirationDate = item.expirationDate;

                final expired = expirationDate.isBefore(now);

                return ListTile(
                  leading: Icon(
                    expired
                        ? Icons.history
                        : Icons.schedule,
                    color: expired
                        ? Colors.red
                        : Colors.orange,
                  ),
                  title: Text(
                    '${check.bonusSum} ${context.l10n.bonusov}',
                  ),
                  subtitle: Text(
                    expired
                        ? '${context.l10n.expired} ${_formatDate(expirationDate)}'
                        : '${context.l10n.expires} ${_formatDate(expirationDate)}',
                  ),
                );
              },
            ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.'
        '${date.month.toString().padLeft(2, '0')}.'
        '${date.year}';
  }
}