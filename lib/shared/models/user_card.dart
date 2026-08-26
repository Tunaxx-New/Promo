import 'package:promo/shared/models/company.dart';

class UserCard {
  final String cardId;
  final Company? company;
  final String companyBin;
  final double discountPercent;
  final double bonusesSum;

  const UserCard({
    required this.cardId,
    required this.company,
    required this.companyBin,
    required this.discountPercent,
    required this.bonusesSum,
  });

  factory UserCard.fromJson(Map<String, dynamic> json, Company? company, double bonusesSum) {
    return UserCard(
      cardId: json['card_id'],
      company: company,
      companyBin: json['company_bin'],
      discountPercent: (json['discount_percent'] as num?)?.toDouble() ?? 0.0,
      bonusesSum: bonusesSum,
    );
  }
}
