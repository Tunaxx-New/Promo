import 'package:flutter/material.dart';
import 'package:promo/shared/formatters/form_date.dart';

class PromotionCard extends StatelessWidget {
  final Map<String, dynamic> promotion;

  const PromotionCard({super.key, required this.promotion});

  void _showDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (promotion['image_url'] != null)
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: SizedBox(
                        width: double.maxFinite,
                        height: 200,
                        child: Image.network(
                          promotion['image_url'],
                          width: double.infinity,
                          height: 220,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          promotion['title'] ?? '-',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),

                        const SizedBox(height: 12),

                        _field('Company ID', promotion['company_id']),

                        _field('Created at', promotion['created_at']),

                        const SizedBox(height: 12),

                        Text(
                          promotion['description'] ?? '-',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _field(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
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
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _showDetails(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (promotion['image_url'] != null)
              SizedBox(
                width: double.infinity,
                height: 180,
                child: Image.network(
                  promotion['image_url'],
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return const Center(
                      child: Icon(Icons.image_not_supported, size: 48),
                    );
                  },
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    promotion['title'] ?? '-',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  const SizedBox(height: 8),

                  Text('Company: ${promotion['company_id'] ?? '-'}'),

                  const SizedBox(height: 4),

                  Text(
                    'Created: ${promotion['created_at'] != null ? formatDate(promotion['created_at']) : '-'}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
