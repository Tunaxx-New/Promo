import 'package:promo/core/api/minio.dart';

class Service {
  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    required this.priceType,
    required this.bonusCount,
    required this.companyId,
    this.companyName,
    required this.imageUrl,
  });

  final String? id;
  final String name;
  final String description;
  final double? price;
  final int? currency;
  final String? priceType;
  final int bonusCount;
  final String companyId;
  String? companyName;
  final String? imageUrl;

  factory Service.fromJson(
    Map<String, dynamic> json,
    MinioStorage minio, {
    String? companyName = null,
  }) {
    final id = json['id'] as String?;

    return Service(
      id: id,
      name: json['title'] as String,
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble(),
      currency: json['currency'] as int?,
      priceType: json['price_type'] as String?,
      bonusCount: json['bonus_amount'] as int,
      companyId: json['company_id'] as String,
      companyName: companyName,
      imageUrl: id != null
          ? minio.imageUrlFromBucket('services', '$id.png')
          : null,
    );
  }
}
