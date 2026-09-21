import 'package:flutter/material.dart';
import 'package:promo/app/app.dart';

import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/theme/app_colors.dart';

/// Приветствие пользователя и кнопки языка/профиля в шапке экрана.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.userName, this.onProfileTap});

  final String userName;
  final VoidCallback? onProfileTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${context.l10n.hello}, $userName!',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ),

        const SizedBox(width: 8),

        const _LanguageButton(),

        const SizedBox(width: 8),

        _ProfileButton(onTap: onProfileTap),
      ],
    );
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton();

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);

    return PopupMenuButton<Locale>(
      tooltip: context.l10n.localeName,
      initialValue: locale,
      onSelected: (locale) {
        App.of(context).setLocale(locale);
      },
      itemBuilder: (context) => const [
        PopupMenuItem(value: Locale('en'), child: Text('EN')),
        PopupMenuItem(value: Locale('ru'), child: Text('RU')),
        PopupMenuItem(value: Locale('kk'), child: Text('KK')),
      ],
      child: Material(
        color: AppColors.surfaceLight,
        shape: const StadiumBorder(side: BorderSide(color: AppColors.border)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          child: SizedBox(
            height: 44,
            width: 52,
            child: Center(
              child: Text(
                locale.languageCode.toUpperCase(),
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileButton extends StatelessWidget {
  const _ProfileButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceLight,
      shape: const CircleBorder(side: BorderSide(color: AppColors.border)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: const SizedBox(
          width: 44,
          height: 44,
          child: Icon(
            Icons.person_outline,
            color: AppColors.textSecondary,
            size: 24,
          ),
        ),
      ),
    );
  }
}
