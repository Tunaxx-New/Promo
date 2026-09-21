import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/formatters/form_date.dart';
import 'package:promo/shared/formatters/form_money.dart';
import 'package:promo/shared/models/payment_check.dart';
import 'package:promo/shared/models/payment_check_product.dart';

class PaymentCheckDetails extends StatelessWidget {
  final PaymentCheck check;

  const PaymentCheckDetails({
    super.key,
    required this.check,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.check),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _CheckHeader(check: check),
          const SizedBox(height: 16),

          _SectionCard(
            title: context.l10n.products,
            child: Column(
              children: [
                for (final product in check.items)
                  _ProductRow(product: product),
              ],
            ),
          ),

          const SizedBox(height: 12),

          _TotalsCard(check: check),
        ],
      ),
    );
  }
}

class _CheckHeader extends StatelessWidget {
  final PaymentCheck check;

  const _CheckHeader({
    required this.check,
  });

  @override
  Widget build(BuildContext context) {
    final bonusColor = check.bonusSum > 0
        ? Colors.green
        : check.bonusSum < 0
            ? Colors.red
            : null;

    final bonusText = check.bonusSum > 0
        ? '+${check.bonusSum}'
        : check.bonusSum.toString();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Column(
        children: [
          const Icon(
            Icons.receipt_long_outlined,
            size: 48,
          ),
          const SizedBox(height: 12),

          Text(
            '$bonusText ${context.l10n.bonusov}',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: bonusColor,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            formatDate(context, check.processedAt.toString()),
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: 4),

          Text(
            '${context.l10n.check} №${check.checkNumber}',
            style: Theme.of(context).textTheme.bodySmall,
          ),

          const SizedBox(height: 4),

          Text(
            check.id,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _ProductRow extends StatelessWidget {
  final PaymentCheckProduct product;

  const _ProductRow({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final bonusText = product.bonus > 0
        ? '+${product.bonus}'
        : product.bonus.toString();

    final bonusColor = product.bonus > 0
        ? Colors.green
        : product.bonus < 0
            ? Colors.red
            : null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name.trim(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${product.amount} × ${formatMoney(product.price)} ₸',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${formatMoney(product.price * product.amount)} ₸',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              if (product.bonus != 0) ...[
                const SizedBox(height: 3),
                Text(
                  bonusText,
                  style: TextStyle(color: bonusColor),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _TotalsCard extends StatelessWidget {
  final PaymentCheck check;

  const _TotalsCard({
    required this.check,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: context.l10n.summary,
      child: Column(
        children: [
          _TotalRow(
            title: context.l10n.paymentSum,
            value: '${formatMoney(check.sum)} ₸',
          ),

          const SizedBox(height: 10),

          _TotalRow(
            title: context.l10n.bonusesAccured,
            value: check.bonusesAccured > 0
                ? '+${check.bonusesAccured}'
                : check.bonusesAccured.toString(),
            highlighted: check.bonusesAccured != 0,
            valueColor: check.bonusesAccured > 0
                ? Colors.green
                : check.bonusesAccured < 0
                    ? Colors.red
                    : null,
          ),

          const SizedBox(height: 10),

          _TotalRow(
            title: context.l10n.written_off,
            value: check.bonusesWrittenOff > 0
                ? '-${check.bonusesWrittenOff}'
                : '0',
            highlighted: check.bonusesWrittenOff != 0,
            valueColor: check.bonusesWrittenOff > 0
                ? Colors.red
                : null,
          ),

          const SizedBox(height: 10),

          _TotalRow(
            title: context.l10n.expired_off,
            value: check.bonusesExpired > 0
                ? '${check.bonusesExpired}'
                : '0',
            highlighted: check.bonusesExpired != 0,
            valueColor: check.bonusesExpired > 0
                ? Colors.orange
                : null,
          ),

          const Divider(height: 24),

          _TotalRow(
            title: context.l10n.summary,
            value: check.bonusSum > 0
                ? '+${check.bonusSum}'
                : check.bonusSum.toString(),
            highlighted: true,
            valueColor: check.bonusSum > 0
                ? Colors.green
                : check.bonusSum < 0
                    ? Colors.red
                    : null,
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  final String title;
  final String value;
  final bool highlighted;
  final Color? valueColor;

  const _TotalRow({
    required this.title,
    required this.value,
    this.highlighted = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontWeight: highlighted
                ? FontWeight.bold
                : null,
          ),
        ),
      ],
    );
  }
}