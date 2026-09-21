import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/formatters/currency_name.dart';
import 'package:promo/shared/models/service.dart';
import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/theme/app_theme.dart';

class ServiceBanner extends StatelessWidget {
  const ServiceBanner({super.key, required this.service, this.onTap});

  final Service service;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: AppTheme.cardRadius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 82,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: AppTheme.cardRadius,
            border: Border.all(color: AppColors.border),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF0A2E52), Color(0xFF071B36)],
            ),
          ),
          child: Row(
            children: [
              // Иконка слева
              if (service.bonusCount != 0)
                Container(
                  width: 44,
                  height: 44,
                  padding: const EdgeInsets.all(9),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: service.imageUrl != null
                      ? Image.network(service.imageUrl!, fit: BoxFit.contain)
                      : const SizedBox.shrink(),
                ),

              const SizedBox(width: 12),

              // Название
              Expanded(
                child: Text(
                  service.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Бонусы справа
              Text(
                service.bonusCount != 0
                    ? '+${service.bonusCount}'
                    : service.price == null
                    ? ''
                    : '${service.price} ${currencyName(service.currency)}',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),

              if (service.bonusCount != 0) ...[
                const SizedBox(width: 4),
                Text(
                  context.l10n.bonusov,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
