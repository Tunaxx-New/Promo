import 'package:flutter/material.dart';
import 'package:promo/core/api/api.dart';
import 'package:promo/features/authorization/widgets/code_form.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/theme/app_strings.dart';
import 'package:promo/shared/widgets/api_form/api_exception.dart';
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
      privacyPolicyUrl: AppStrings.privacyPolicyUrl,
      route: '/auth/register',
      method: HttpMethod.post,
      fields: [
        ApiField.text(key: 'name', label: context.l10n.name, required: true),
        ApiField.phone(
          key: 'phone',
          label: context.l10n.authorizationPhoneTitle,
          required: true,
        ),
      ],
      onSuccess: (json) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CodeForm(
              userId: json['user_id'].toString(),
              action: 'activate_account',
            ),
          ),
        );
      },
      errorColors: {409: Colors.green},
      onError: (e, data) async {
        if (e is ApiException && e.statusCode == 409) {
          final json = await api.request(
            route: '/auth/resend-registration-code',
            method: HttpMethod.post,
            body: {
              'phone': data['phone'],
              'platform': 'WHATSAPP',
              'action': 'reset_token',
            },
          );

          if (!context.mounted) return;

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CodeForm(
                userId: json['user_id'].toString(),
                action: 'reset_token',
              ),
            ),
          );
        }
      },
    );
  }
}
