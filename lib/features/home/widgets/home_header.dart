import 'package:flutter/material.dart';
import 'package:promo/app/app.dart';

import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/widgets/language_button.dart';

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

        const LanguageButton(),

        const SizedBox(width: 8),

        _ProfileButton(onTap: onProfileTap),
      ],
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
