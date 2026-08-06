import 'package:flutter/material.dart';
import 'package:promo/core/api/api.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/widgets/api_form/api_form.dart';
import 'package:promo/shared/widgets/api_form/api_field.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';
import 'package:promo/shared/widgets/app_bars/app_bar_roof.dart';

class UpdatePromocodePage extends StatelessWidget {
  final Map<String, dynamic> promocode;

  const UpdatePromocodePage({super.key, required this.promocode});

  @override
  Widget build(BuildContext context) {
    return AppBarRoof(
      title: context.l10n.companyUpdatePromocodeTitle,
      description: context.l10n.companyUpdatePromocodeDescription,
      showBackButton: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ApiForm(
          apiClient: api,
          title: '${context.l10n.update} ${context.l10n.promocode}',
          submitTitle: context.l10n.save,
          route: '/promo/promocode',
          method: HttpMethod.put,
          fields: [
            ApiField.hidden(key: 'id', initialValue: promocode['id']),

            ApiField.text(
              key: 'title',
              label: context.l10n.title,
              initialValue: promocode['title'],
              haveTitle: true,
            ),

            ApiField.text(
              key: 'code',
              label: context.l10n.code,
              initialValue: promocode['code'],
              haveTitle: true,
            ),

            ApiField.text(
              key: 'description',
              label: context.l10n.description,
              initialValue: promocode['description'],
              maxLines: 3,
              haveTitle: true,
            ),

            ApiField.number(
              key: 'discount_percent',
              label: context.l10n.discount_percent,
              initialValue: promocode['discount_percent']?.toString(),
              haveTitle: true,
            ),

            ApiField.number(
              key: 'discount_amount',
              label: context.l10n.discount_amount,
              initialValue: promocode['discount_amount']?.toString(),
              haveTitle: true,
            ),

            ApiField.number(
              key: 'usage_limit',
              label: context.l10n.usage_limit,
              initialValue: promocode['usage_limit']?.toString(),
              haveTitle: true,
            ),

            ApiField.dateTime(
              key: 'starts_at',
              label: context.l10n.starts_at,
              initialValue: promocode['starts_at'],
              haveTitle: true,
            ),

            ApiField.dateTime(
              key: 'expires_at',
              label: context.l10n.expires_at,
              initialValue: promocode['expires_at'],
              haveTitle: true,
            ),

            ApiField.checkbox(
              key: 'is_active',
              label: context.l10n.is_active,
              initialValue: promocode['is_active'].toString(),
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
