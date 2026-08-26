import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/models/payment_check.dart';
import 'package:promo/shared/models/payment_check_product.dart';
import 'package:promo/shared/widgets/bonuses/check_card.dart';
import 'package:promo/shared/widgets/bonuses/check_card_details.dart';
import 'package:promo/shared/widgets/bonuses/expired_bonuses_page.dart';

class BonusesDetails extends StatefulWidget {
  final List<PaymentCheck> checks;

  const BonusesDetails({super.key, required this.checks});

  @override
  State<BonusesDetails> createState() => _BonusesDetailsState();
}

class _BonusesDetailsState extends State<BonusesDetails> {
  @override
  Widget build(BuildContext context) {
    final totalAccured = widget.checks.fold<double>(
      0,
      (sum, check) => sum + check.bonusesAccured,
    );

    final totalWrittenOff = widget.checks.fold<double>(
      0,
      (sum, check) => sum + check.bonusesWrittenOff,
    );

    final totalExpired = widget.checks.fold<double>(
      0,
      (sum, check) => sum + check.bonusesExpired,
    );

    final totalBonusSum = widget.checks.fold<double>(
      0,
      (sum, check) => sum + check.bonusSum,
    );

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.bonuses)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _BonusesSummary(
              bonusSum: totalBonusSum,
              accured: totalAccured,
              writtenOff: totalWrittenOff,
              expired: totalExpired,
              checksCount: widget.checks.length,
              checks: widget.checks,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: widget.checks.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final check = widget.checks[index];

                  return PaymentCheckCard(
                    check: check,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PaymentCheckDetails(check: check),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BonusesSummary extends StatelessWidget {
  final double bonusSum;
  final double accured;
  final double writtenOff;
  final double expired;
  final int checksCount;
  final List<PaymentCheck> checks;

  const _BonusesSummary({
    required this.bonusSum,
    required this.accured,
    required this.writtenOff,
    required this.expired,
    required this.checksCount,
    required this.checks,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.colorScheme.surfaceContainerHighest,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.summary,
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '+$bonusSum',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(context.l10n.checkov, style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 6),
                  Text(
                    '$checksCount',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _BonusValue(
                  label: context.l10n.written_off,
                  value: writtenOff,
                  color: Colors.red,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ExpiredBonusesPage(checks: checks),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _BonusValue(
                            label: context.l10n.expired_off,
                            value: expired,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            Icons.info_outline,
                            size: 18,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _BonusValue(
                  label: context.l10n.bonusesAccured,
                  value: accured,
                  color: accured >= 0 ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BonusValue extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _BonusValue({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4),
        Text(
          '$value B',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
