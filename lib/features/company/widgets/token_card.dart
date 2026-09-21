import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/formatters/form_date.dart';
import 'package:promo/shared/widgets/qr_code_dialog.dart';

class TokenCard extends StatelessWidget {
  final Map<String, dynamic> token;
  final VoidCallback? onDelete;
  final ValueChanged<bool>? onActiveChanged;

  const TokenCard({
    super.key,
    required this.token,
    this.onDelete,
    this.onActiveChanged,
  });

  Widget _field(String title, dynamic value) => Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(child: Text(value?.toString() ?? '-')),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                token['name'],
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: const Text('********************'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Switch(
                    value: token['is_active'] as bool,
                    onChanged: (value) => onActiveChanged?.call(value),
                  ),
                  IconButton(
                    tooltip: context.l10n.delete,
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ),
            const Divider(height: 12),
            _field(context.l10n.expires_at, formatDate(context, token['expires_at'])),
            _field(context.l10n.created_at, formatDate(context, token['created_at'])),
          ],
        ),
      ),
    );
  }
}
