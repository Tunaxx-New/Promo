import 'package:flutter/material.dart';
import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/theme/app_theme.dart';


/// Рекламный баннер внизу экрана: текст акции, бейдж со скидкой
/// и опциональная картинка машины справа.
class PromoBanner extends StatelessWidget {
  const PromoBanner({
    super.key,
    required this.title,
    required this.discountLabel,
    this.imageAsset,
    this.onTap,
  });

  final String title;
  final String discountLabel;
  final String? imageAsset;
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
          height: 110,
          decoration: BoxDecoration(
            borderRadius: AppTheme.cardRadius,
            border: Border.all(color: AppColors.border),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF0A2E52), Color(0xFF071B36)],
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (imageAsset != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: 0.6,
                    child: Image.asset(imageAsset!, fit: BoxFit.cover),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 190,
                      child: Text(
                        title.toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          height: 1.25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: const BoxDecoration(
                        gradient: AppColors.accentGradient,
                        borderRadius: AppTheme.pillRadius,
                      ),
                      child: Text(
                        discountLabel,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
