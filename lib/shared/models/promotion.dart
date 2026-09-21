import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/theme/app_colors.dart';

class Promotion {
  Promotion({
    required this.id,
    required this.title,
    this.description,
    this.tag,
    required this.priority,
    required this.createdAt,
    required this.companyId,
    this.imageUrl,
  });

  final String id;
  final String title;
  final String? description;
  final PromotionTag? tag;
  final int priority;
  final DateTime createdAt;
  final String companyId;
  late String companyName;
  final String? imageUrl;

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      tag: json['tag'] != null
          ? PromotionTag.fromValue(json['tag'] as String)
          : null,
      priority: json['priority'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      companyId: json['company_id'] as String,
      imageUrl: json['image_url'] as String?,
    );
  }
}

enum PromotionTag {
  promotion('Promotion', AppColors.danger),
  partner('Partner', AppColors.primary),
  newTag('New', AppColors.success),
  useful('Useful', AppColors.info),
  deprecated('Deprecated', Colors.grey);

  const PromotionTag(this.value, this.color);

  final String value;
  final Color color;

  static PromotionTag fromValue(String value) {
    return PromotionTag.values.firstWhere(
      (tag) => tag.value == value,
      orElse: () => throw ArgumentError('Unknown PromotionTag: $value'),
    );
  }
}

String promotionTagLabel(BuildContext context, PromotionTag? tag) {
  if (tag == null) return '';

  return switch (tag) {
    PromotionTag.promotion => context.l10n.promotions,
    PromotionTag.partner => context.l10n.partners,
    PromotionTag.newTag => context.l10n.new_,
    PromotionTag.useful => context.l10n.useful,
    PromotionTag.deprecated => '',
  };
}
