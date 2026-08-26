import 'package:flutter/material.dart';
import 'package:promo/core/api/api.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/widgets/api_form/api_field.dart';
import 'package:promo/shared/widgets/api_form/api_form.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';
import 'package:promo/shared/widgets/app_bars/app_bar_roof.dart';

class UpdateCompanyProfileWidget extends StatelessWidget {
  final Map<String, dynamic> company;
  final VoidCallback? onUpdated;

  const UpdateCompanyProfileWidget({
    super.key,
    required this.company,
    this.onUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return AppBarRoof(
      title: context.l10n.companyUpdateTitle,
      description: context.l10n.companyUpdateTitle,
      showBackButton: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ApiForm(
          apiClient: api,
          title: context.l10n.companyUpdateTitle,
          submitTitle: context.l10n.update,
          route: '/promo/company',
          method: HttpMethod.put,
          fields: [
            ApiField.text(
              key: 'name',
              label: context.l10n.companyName,
              initialValue: company['name'] ?? '',
              required: true,
            ),
          ],
          onSuccess: (company) {
            onUpdated?.call();
            Navigator.pop(context, true);
          },
        ),
      ),
    );
  }
}
