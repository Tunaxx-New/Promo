import 'package:flutter/material.dart';
import 'package:promo/app/routes.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/widgets/language_button.dart';

class UnauthorizedPage extends StatelessWidget {
  const UnauthorizedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Image.asset(
            'assets/images/unauthorized_background.png',
            fit: BoxFit.cover,
          ),

          // Dark overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.25),
                  Colors.black.withOpacity(0.15),
                  Colors.black.withOpacity(0.65),
                ],
              ),
            ),
          ),
          
          Positioned(top: 12, right: 16, child: const LanguageButton()),

          SafeArea(
            child: Column(
              children: [
                // Logo + text
                Padding(
                  padding: const EdgeInsets.only(top: 45, left: 0, right: 0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.2,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/logo_detailed_light.png',
                          width: double.infinity,
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.topCenter,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        context.l10n.slogan.replaceFirst(' - ', ' -\n'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                          shadows: const [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 6,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Bottom buttons
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.authorization,
                              arguments: 0,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            context.l10n.authorizationLoginTitle,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.authorization,
                              arguments: 1,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: colorScheme.onPrimary,
                            side: BorderSide(
                              color: colorScheme.secondary,
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                          child: Text(
                            context.l10n.authorizationRegisterTitle,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
