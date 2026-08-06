import 'package:flutter/material.dart';
import 'package:promo/core/api/api.dart';
import 'package:promo/shared/extensions/generate_token.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/widgets/api_form/api_form.dart';
import 'package:promo/shared/widgets/api_form/api_field.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';
import 'package:promo/shared/widgets/app_bars/app_bar_roof.dart';

class CreateTokenPage extends StatefulWidget {
  final String companyId;

  const CreateTokenPage({super.key, required this.companyId});

  @override
  State<CreateTokenPage> createState() => _CreateTokenPageState();
}

class _CreateTokenPageState extends State<CreateTokenPage> {
  final String _generatedToken = generateToken();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange),
          title: Text(context.l10n.warning),
          content: Text(context.l10n.hintSaveThisToken),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.l10n.ok),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBarRoof(
      title: context.l10n.companyCreateTokenTitle,
      description: context.l10n.companyCreateTokenDescription,
      showBackButton: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ApiForm(
          apiClient: api,
          title: '${context.l10n.create} ${context.l10n.api_token}',
          submitTitle: context.l10n.save,
          route: '/promo/company/token',
          method: HttpMethod.post,
          fields: [
            ApiField.hidden(key: 'company_id', initialValue: widget.companyId),

            ApiField.text(
              key: 'token',
              label: context.l10n.api_token,
              initialValue: _generatedToken,
              haveTitle: true,
              required: true,
              hint: context.l10n.hintSaveThisToken,
            ),

            ApiField.text(
              key: 'name',
              label: context.l10n.name,
              initialValue: '',
              haveTitle: true,
              required: true,
            ),

            ApiField.dateTime(
              key: 'expires_at',
              label: context.l10n.expires_at,
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
