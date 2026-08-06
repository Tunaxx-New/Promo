import 'package:flutter/material.dart';
import 'package:promo/core/api/api.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/widgets/api_form/api_form.dart';
import 'package:promo/shared/widgets/api_form/api_field.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';
import 'package:promo/shared/widgets/app_bars/app_bar_roof.dart';
import 'package:promo/shared/widgets/authorization/authorization_service.dart';

class CodeForm extends StatelessWidget {
  final String userId;
  final String action;
  final AuthorizationService auth;

  CodeForm({
    super.key,
    required this.userId,
    required this.action,
    AuthorizationService? auth,
  }) : auth = auth ?? AuthorizationService();

  @override
  Widget build(BuildContext context) {
    return AppBarRoof(
      title: context.l10n.authorizationCodeTitle,
      description: context.l10n.authorizationPasteCodeDescription,
      showBackButton: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ApiForm(
          apiClient: api,
          title: context.l10n.authorizationCodeTitle,
          submitTitle: context.l10n.authorizationCodeTitle,
          route: '/auth/confirm-registration',
          method: HttpMethod.post,
          fields: [
            ApiField.code(
              key: 'code',
              label: context.l10n.authorizationPhoneTitle,
              required: true,
            ),
            ApiField.hidden(key: 'user_id', initialValue: userId),
            ApiField.hidden(key: 'action', initialValue: action),
          ],
          onSuccess: (json) async {
            await auth.saveAccessToken(json['access_token']);
            await auth.saveRefreshToken(json['refresh_token']);

            if (context.mounted) {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil('/', (route) => false);
            }
          },
        ),
      ),
    );
  }
}
