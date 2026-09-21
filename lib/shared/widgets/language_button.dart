import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:promo/app/app.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/theme/app_colors.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton();

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
