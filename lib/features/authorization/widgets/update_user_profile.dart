import 'package:flutter/material.dart';
import 'package:promo/core/api/api.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/widgets/api_form/api_field.dart';
import 'package:promo/shared/widgets/api_form/api_form.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';
import 'package:promo/shared/widgets/app_bars/app_bar_roof.dart';

class UpdateUserProfileWidget extends StatelessWidget {
  final Map<String, dynamic> user;
  final VoidCallback? onUpdated;

  const UpdateUserProfileWidget({
    super.key,
    required this.user,
    this.onUpdated,
  });

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
          title: context.l10n.userUpdateTitle,
          submitTitle: context.l10n.update,
          route: '/auth/profile',
          method: HttpMethod.put,
          fields: [
            ApiField.text(
              key: 'name',
              label: context.l10n.username,
              initialValue: user['name'] ?? '',
              required: true,
            ),
          ],
          onSuccess: (user) {
             onUpdated?.call();
             Navigator.pop(context, true);
          }
        ),
      ),
    );
  }
}
