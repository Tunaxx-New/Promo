import 'package:flutter/material.dart';
import 'package:promo/core/api/api.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/widgets/api_form/api_field.dart';
import 'package:promo/shared/widgets/api_form/api_form.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';
import 'package:promo/shared/widgets/app_bars/app_bar_roof.dart';

class DeleteUserProfileWidget extends StatelessWidget {
  final Map<String, dynamic> user;
  final VoidCallback? onDeleted;

  const DeleteUserProfileWidget({
    super.key,
    required this.user,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return AppBarRoof(
      title: context.l10n.userDeleteTitle,
      description: context.l10n.userDeleteDescription,
      showBackButton: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ApiForm(
          apiClient: api,
          title: context.l10n.userDeleteTitle,
          submitTitle: context.l10n.delete,
          route: '/auth/profile',
          method: HttpMethod.delete,
          fields: [],
          onSuccess: (user) {
             onDeleted?.call();
          }
        ),
      ),
    );
  }
}
