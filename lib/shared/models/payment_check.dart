import 'package:promo/shared/models/company.dart';
import 'package:promo/shared/models/payment_check_product.dart';

class PaymentCheck {
  final String id;
  final int checkNumber;
  final String cardId;
  final String companyBin;
  final double discountPercent;
  final DateTime processedAt;
  final List<PaymentCheckProduct> items;
  final double sum;
  final double bonusSum;
  final double bonusesAccured;
  final double bonusesWrittenOff;
  final double bonusesExpired;

  const PaymentCheck({
    required this.id,
    required this.checkNumber,
    required this.cardId,
    required this.companyBin,
    required this.discountPercent,
    required this.processedAt,
    required this.items,
    required this.sum,
    required this.bonusSum,
    required this.bonusesAccured,
    required this.bonusesWrittenOff,
    required this.bonusesExpired,
  });

  factory PaymentCheck.fromJson(Map<String, dynamic> json) {
    return PaymentCheck(
      id: json['id'] as String,
      checkNumber: json['check_number'] as int,
      cardId: json['card_id'] as String,
      companyBin: json['company_bin'] as String,
      discountPercent: (json['discount_percent'] as num?)?.toDouble() ?? 0.0,
      processedAt: DateTime.parse(json['processed_at'] as String),
      items: (json['items'] as List)
          .map(
            (item) => PaymentCheckProduct.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
      sum: (json['sum'] as num?)?.toDouble() ?? 0.0,
      bonusSum: (json['bonus_sum'] as num?)?.toDouble() ?? 0.0,
      bonusesAccured: (json['bonuses_accured'] as num?)?.toDouble() ?? 0.0,
      bonusesWrittenOff: (json['bonuses_written_off'] as num?)?.toDouble() ?? 0.0,
      bonusesExpired: (json['bonuses_expired'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
