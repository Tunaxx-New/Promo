import 'package:flutter/material.dart';
import 'package:promo/features/authorization/widgets/login_form.dart';
import 'package:promo/features/authorization/widgets/register_form.dart';

import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/widgets/app_bars/app_bar_roof.dart';
import 'package:promo/shared/widgets/app_version_text.dart';
import 'package:promo/shared/widgets/menus/toggle_menu.dart';

class AuthorizationPage extends StatefulWidget {
  final int selected;

  const AuthorizationPage({super.key, this.selected = 0});

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  late int _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return AppBarRoof(
      title: context.l10n.authorizationTitle,
      description: context.l10n.authorizationDescription,
      showBackButton: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ToggleMenu(
              selectedIndex: _selected,
              onChanged: (value) {
                setState(() => _selected = value);
              },
              options: [
                context.l10n.authorizationLoginTitle,
                context.l10n.authorizationRegisterTitle,
              ],
            ),

            const SizedBox(height: 16),

            Expanded(
              child: SizedBox.expand(
                child: _selected == 0
                    ? const LoginForm()
                    : const RegisterForm(),
              ),
            ),

            AppVersionText(),
          ],
        ),
      ),
    );
  }
}
