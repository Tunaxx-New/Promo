import 'package:flutter/material.dart';
import 'package:promo/core/api/api.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/widgets/api_form/api_form.dart';
import 'package:promo/shared/widgets/api_form/api_field.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';
import 'package:promo/shared/widgets/app_bars/app_bar_roof.dart';

class CreatePromocodePage extends StatelessWidget {
  const CreatePromocodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBarRoof(
      title: context.l10n.companyCreatePromocodeTitle,
      description: context.l10n.companyCreatePromocodeDescription,
      showBackButton: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ApiForm(
          apiClient: api,
          title: '${context.l10n.update} ${context.l10n.promocode}',
          submitTitle: context.l10n.save,
          route: '/promo/promocode',
          method: HttpMethod.post,
          fields: [
            ApiField.text(
              key: 'title',
              label: context.l10n.title,
              initialValue: '',
              haveTitle: true,
            ),

            ApiField.text(
              key: 'code',
              label: context.l10n.code,
              initialValue: '',
              haveTitle: true,
            ),

            ApiField.text(
              key: 'description',
              label: context.l10n.description,
              maxLines: 3,
              haveTitle: true,
            ),

            ApiField.number(
              key: 'discount_percent',
              label: context.l10n.discount_percent,
              haveTitle: true,
            ),

            ApiField.number(
              key: 'discount_amount',
              label: context.l10n.discount_amount,
              haveTitle: true,
            ),

            ApiField.number(
              key: 'usage_limit',
              label: context.l10n.usage_limit,
              haveTitle: true,
            ),

            ApiField.dateTime(
              key: 'starts_at',
              label: context.l10n.starts_at,
              haveTitle: true,
            ),

            ApiField.dateTime(
              key: 'expires_at',
              label: context.l10n.expires_at,
              haveTitle: true,
            ),

            ApiField.checkbox(
              key: 'is_active',
              label: context.l10n.is_active,
              haveTitle: true,
            ),
          ],
          onSuccess: (_) {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
