import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/theme/app_colors.dart';

class News {
  News({
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
  final NewsTag? tag;
  final int priority;
  final DateTime createdAt;
  final String companyId;
  late String companyName;
  final String? imageUrl;

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      tag: json['tag'] != null
          ? NewsTag.fromValue(json['tag'] as String)
          : null,
      priority: json['priority'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      companyId: json['company_id'] as String,
      imageUrl: json['image_url'] as String?,
    );
  }
}

enum NewsTag {
  auto('Auto', AppColors.danger),
  company('Company', AppColors.primary),
  partner('Partner', AppColors.primary),
  newTag('New', AppColors.success),
  useful('Useful', AppColors.info),
  deprecated('Deprecated', Colors.grey);

  const NewsTag(this.value, this.color);

  final String value;
  final Color color;

  static NewsTag fromValue(String value) {
    return NewsTag.values.firstWhere(
      (tag) => tag.value == value,
      orElse: () => throw ArgumentError('Unknown PromotionTag: $value'),
    );
  }
}

String newsTagLabel(BuildContext context, NewsTag? tag) {
  if (tag == null) return '';

  return switch (tag) {
    NewsTag.auto => context.l10n.auto,
    NewsTag.company => context.l10n.company,
    NewsTag.partner => context.l10n.partners,
    NewsTag.newTag => context.l10n.new_,
    NewsTag.useful => context.l10n.useful,
    NewsTag.deprecated => '',
  };
}
