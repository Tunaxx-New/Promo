import 'package:flutter/material.dart';
import 'package:promo/core/api/api.dart';
import 'package:promo/features/authorization/widgets/code_form.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/widgets/api_form/api_form.dart';
import 'package:promo/shared/widgets/api_form/api_field.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ApiForm(
      apiClient: api,
      title: context.l10n.authorizationRegisterTitle,
      submitTitle: context.l10n.authorizationRegisterTitle,
      route: '/auth/register',
      method: HttpMethod.post,
      fields: [
        ApiField.phone(
          key: 'phone',
          label: context.l10n.authorizationPhoneTitle,
          required: true,
        ),
      ],
      onSuccess: (json) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CodeForm(
              userId: json['user_id'].toString(),
              action: 'activate_account',
            ),
          ),
        );
      },
    );
  }
}
