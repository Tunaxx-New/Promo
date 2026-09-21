import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:promo/features/authorization/widgets/update_user_profile.dart';
import 'package:promo/features/profile/widgets/profile_menu_item.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/formatters/kazakhstsan_phone_formatter.dart';
import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/theme/app_theme.dart';
import 'package:promo/shared/widgets/levels/level_progress.dart';

/// Экран профиля пользователя.
class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required this.userName,
    required this.userPhone,
    this.avatarUrl,
    required this.balance,
    required this.onBonuses,
    required this.onCars,
    required this.onNotifications,
    required this.onSettings,
    required this.onAbout,
    required this.onUpdateUser,
    required this.onDeleteUser,
    required this.onLogout,
  });

  final String? userName;
  final String? userPhone;
  final String? avatarUrl;
  final ValueListenable<double> balance;

  final VoidCallback onBonuses;
  final VoidCallback onCars;
  final VoidCallback onNotifications;
  final VoidCallback onSettings;
  final VoidCallback onAbout;
  final VoidCallback onUpdateUser;
  final VoidCallback onDeleteUser;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final items = [
      ProfileMenuItem(
        icon: Icons.attach_money,
        title: context.l10n.my_bonuses,
        onTap: onBonuses,
        isFirst: true,
      ),
      ProfileMenuItem(
        icon: Icons.directions_car_outlined,
        title: context.l10n.my_cars,
        onTap: onCars,
      ),
      ProfileMenuItem(
        icon: Icons.notifications_none,
        title: context.l10n.notifications,
        onTap: onNotifications,
      ),
      ProfileMenuItem(
        icon: Icons.settings_outlined,
        title: context.l10n.settings,
        onTap: onSettings,
      ),
      ProfileMenuItem(
        icon: Icons.info_outline,
        title: context.l10n.about_app,
        onTap: onAbout,
      ),
      ProfileMenuItem(
        icon: Icons.update,
        title: context.l10n.userUpdateTitle,
        onTap: onUpdateUser,
      ),
      ProfileMenuItem(
        icon: Icons.logout,
        title: context.l10n.authorizationLogoutTitle,
        onTap: onLogout,
      ),
      ProfileMenuItem(
        icon: Icons.delete,
        title: context.l10n.userDeleteTitle,
        onTap: onDeleteUser,
        isLast: true,
      ),
    ];

    final phoneFormatter = KazakhstanPhoneFormatter();
    final formattedUserPhone = phoneFormatter.format(userPhone ?? '-');

    return ValueListenableBuilder<double>(
      valueListenable: balance,
      builder: (context, balance, _) {
        return Scaffold(
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                Text(
                  context.l10n.profile,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 20),

                // ─────────────────────────────
                // USER CARD
                // ─────────────────────────────
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: AppTheme.cardRadius,
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 48,
                          backgroundColor: AppColors.border,
                          backgroundImage: avatarUrl != null
                              ? NetworkImage(avatarUrl!)
                              : null,
                          child: avatarUrl == null
                              ? Icon(
                                  Icons.person,
                                  size: 48,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName ?? context.l10n.guest,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formattedUserPhone,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                LevelProgress(
                  current: balance.toInt(),
                  iconSize: 60.0,
                  padding: const EdgeInsets.all(8),
                  border: Border.all(color: AppColors.border),
                ),

                const SizedBox(height: 20),

                // ─────────────────────────────
                // MENU
                // ─────────────────────────────
                Container(
                  decoration: BoxDecoration(
                    borderRadius: AppTheme.cardRadius,
                    border: Border.all(color: AppColors.border),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      for (int i = 0; i < items.length; i++) ...[items[i]],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
