import 'package:flutter/material.dart';
import 'package:promo/core/api/api.dart';
import 'package:promo/features/authorization/widgets/code_form.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/widgets/api_form/api_form.dart';
import 'package:promo/shared/widgets/api_form/api_field.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ApiForm(
      apiClient: api,
      title: context.l10n.authorizationLoginTitle,
      submitTitle: context.l10n.authorizationGetCodeTitle,
      route: '/auth/resend-registration-code',
      method: HttpMethod.post,
      fields: [
        ApiField.phone(
          key: 'phone',
          label: context.l10n.authorizationPhoneTitle,
          required: true,
        ),
        ApiField.hidden(key: 'platform', initialValue: 'GREENAPI'),
        ApiField.hidden(key: 'action', initialValue: 'reset_token'),
      ],
      onSuccess: (json) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CodeForm(
              userId: json['user_id'].toString(),
              action: 'reset_token',
            ),
          ),
        );
      },
    );
  }
}
