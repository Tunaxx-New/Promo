import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/theme/app_theme.dart';

/// Рекламный баннер внизу экрана: текст акции, бейдж со скидкой
/// и опциональная картинка машины справа.
class PromoBanner extends StatelessWidget {
  const PromoBanner({
    super.key,
    required this.title,
    this.discountLabel,
    this.imageUrl,
    this.tagValue,
    this.tagColor,
    this.onTap,
  });

  final String title;
  final String? discountLabel;
  final String? imageUrl;
  final String? tagValue;
  final Color? tagColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: AppTheme.cardRadius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          height: 190,
          decoration: BoxDecoration(
            color: const Color(0xFF071B36),
            borderRadius: AppTheme.cardRadius,
            border: Border.all(color: AppColors.border),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ─────────────────────────────
              // BACKGROUND IMAGE
              // ─────────────────────────────
              if (imageUrl != null)
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: AppTheme.cardRadius,
                    child: Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      alignment: Alignment.centerRight,
                      errorBuilder: (context, error, stackTrace) {
                        debugPrint('Failed to load promotion image: $error');
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),

              // ─────────────────────────────
              // DARK OVERLAY
              // ─────────────────────────────
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.0, 0.0, 0.4, 1.0],
                      colors: [
                        Color(0xFF0A2E52),
                        Color(0xDD0A2E52),
                        Color(0x550A2E52),
                        Color(0x000A2E52),
                      ],
                    ),
                  ),
                ),
              ),

              // ─────────────────────────────
              // CONTENT
              // ─────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  12,
                  tagValue != null ? 100 : 16,
                  12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toUpperCase(),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        height: 1.2,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 8),

                    if (discountLabel != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: const BoxDecoration(
                          gradient: AppColors.accentGradient,
                          borderRadius: AppTheme.angleRadius,
                        ),
                        child: Text(
                          discountLabel!,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                    const SizedBox(height: 8),
                    const Spacer(),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: AppTheme.pillRadius,
                      ),
                      child: Text(
                        context.l10n.read_more,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ─────────────────────────────
              // TAG
              // ─────────────────────────────
              if (tagValue != null)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: tagColor ?? AppColors.accent,
                      borderRadius: AppTheme.tagRadius,
                    ),
                    child: Text(
                      tagValue!.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              // MUST BE LAST
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTap,
                    borderRadius: AppTheme.angleRadius,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
