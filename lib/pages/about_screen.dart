import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/extensions/open_url.dart';
import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/theme/app_strings.dart';
import 'package:promo/shared/widgets/app_version_text.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const String? privacyPolicyUrl = AppStrings.privacyPolicyUrl;

  static const String? termsOfUseUrl = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppColors.screenGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      context.l10n.about_app,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                if (privacyPolicyUrl != null)
                  ListTile(
                    leading: const Icon(Icons.privacy_tip_outlined),
                    title:  Text(context.l10n.privacyPolicyTitle),
                    trailing: const Icon(Icons.open_in_new),
                    onTap: () {
                      openUrl(privacyPolicyUrl);
                    },
                  ),

                if (termsOfUseUrl != null)
                  ListTile(
                    leading: const Icon(Icons.description_outlined),
                    title: Text(context.l10n.termOfUseTitle),
                    trailing: const Icon(Icons.open_in_new),
                    onTap: () {
                      openUrl(termsOfUseUrl);
                    },
                  ),

                const Spacer(),

                const AppVersionText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
