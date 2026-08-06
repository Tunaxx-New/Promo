import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/formatters/form_date.dart';
import 'package:promo/shared/widgets/qr_code_dialog.dart';

class AdvancedPromocodeCard extends StatefulWidget {
  final Map<String, dynamic> promocode;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const AdvancedPromocodeCard({
    super.key,
    required this.promocode,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<AdvancedPromocodeCard> createState() => _AdvancedPromocodeCardState();
}

class _AdvancedPromocodeCardState extends State<AdvancedPromocodeCard> {
  Widget _field(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              '$title:',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value?.toString() ?? '-')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.promocode['title'],
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(width: 12),

                FilledButton.icon(
                  style: FilledButton.styleFrom(minimumSize: const Size(0, 50)),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => QrCodeDialog(
                        id: widget.promocode['id'].toString(),
                        activateOrShare: false,
                        code: widget.promocode['code'].toString(),
                        title: widget.promocode['title'].toString(),
                        filePrefix: 'promocode',
                      ),
                    );
                  },
                  icon: const Icon(Icons.qr_code),
                  label: Text(context.l10n.qr_code),
                ),
              ],
            ),

            const SizedBox(height: 12),

            _field(context.l10n.id, widget.promocode['id']),
            _field(context.l10n.company_id, widget.promocode['company_id']),
            _field(context.l10n.code, widget.promocode['code']),
            _field(context.l10n.description, widget.promocode['description']),
            _field(
              context.l10n.starts_at,
              formatDate(widget.promocode['starts_at']),
            ),
            _field(
              context.l10n.expires_at,
              formatDate(widget.promocode['expires_at']),
            ),
            _field(
              context.l10n.discount_percent,
              widget.promocode['discount_percent'],
            ),
            _field(
              context.l10n.discount_amount,
              widget.promocode['discount_amount'],
            ),
            _field(context.l10n.usage_limit, widget.promocode['usage_limit']),
            _field(context.l10n.used_count, widget.promocode['used_count']),
            _field(context.l10n.is_active, widget.promocode['is_active']),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(0, 50),
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: widget.onEdit,
                    icon: const Icon(Icons.edit),
                    label: Text(context.l10n.edit),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(0, 50),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: widget.onDelete,
                    icon: const Icon(Icons.delete),
                    label: Text(context.l10n.delete),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
