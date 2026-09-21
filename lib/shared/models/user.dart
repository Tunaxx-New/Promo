import 'package:promo/shared/models/user_card.dart';

class User {
  const User({
    required this.id,
    this.companyId,
    required this.name,
    required this.phone,
    required this.createdAt,
    this.lastLogin,
    required this.isActive,
  });

  final String id;
  final String? companyId;
  final String name;
  final String phone;
  final DateTime createdAt;
  final DateTime? lastLogin;
  final bool isActive;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      companyId: json['company_id'] as String?,
      name: json['name'] as String,
      phone: json['phone'].toString(),
      createdAt: DateTime.parse(json['created_at'] as String),
      lastLogin: json['last_login'] != null
          ? DateTime.parse(json['last_login'] as String)
          : null,
      isActive: json['is_active'] as bool,
    );
  }
}
