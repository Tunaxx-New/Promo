import 'package:flutter/material.dart';
import 'package:promo/core/api/api.dart';
import 'package:promo/features/company/widgets/advanced_promocode_card.dart';
import 'package:promo/features/company/widgets/create_promocode_page.dart';
import 'package:promo/features/company/widgets/create_token_page.dart';
import 'package:promo/features/company/widgets/token_card.dart';
import 'package:promo/features/company/widgets/update_company_profile.dart';
import 'package:promo/features/company/widgets/update_promocode_page.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/formatters/form_date.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';
import 'package:promo/shared/widgets/error_handler.dart';
import 'package:promo/shared/widgets/loading/loading_overlay.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({super.key});

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  bool _loading = true;

  Map<String, dynamic>? _company;
  List<dynamic> _promocodes = [];
  List<dynamic> _tokens = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final response = await api.request(
        route: '/promo/company',
        method: HttpMethod.get,
      );

      if (!mounted) return;

      setState(() {
        _company = response['company'];
        _promocodes = response['promocodes'] ?? [];
        _tokens = response['tokens'] ?? [];
        _loading = false;
      });
    } catch (e) {
      ErrorHandler.show(context, e);
      setState(() => _loading = false);
    }
  }

  Widget _field(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              "$title:",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value?.toString() ?? "-")),
        ],
      ),
    );
  }

  Future<void> _deletePromocode(Map<String, dynamic> promocode) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${context.l10n.delete} ${context.l10n.promocode}'),
        content: Text(
          context.l10n.are_you_sure_to_delete(
            context.l10n.promocode,
            promocode['id'],
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                    minimumSize: const Size(0, 48),
                  ),
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(context.l10n.cancel),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(0, 48),
                  ),
                  onPressed: () => Navigator.pop(context, true),
                  icon: const Icon(Icons.delete),
                  label: Text(context.l10n.delete),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await api.request(
        route: '/promo/promocode?promocode_id=${promocode['id']}',
        method: HttpMethod.delete,
      );
    } catch (e) {
      ErrorHandler.show(context, e);
    }

    await _load();
  }

  Future<void> _deleteToken(Map<String, dynamic> token) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${context.l10n.delete} ${context.l10n.api_token}'),
        content: Text(
          context.l10n.are_you_sure_to_delete(
            context.l10n.api_token,
            token['id'],
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                    minimumSize: const Size(0, 48),
                  ),
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(context.l10n.cancel),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(0, 48),
                  ),
                  onPressed: () => Navigator.pop(context, true),
                  icon: const Icon(Icons.delete),
                  label: Text(context.l10n.delete),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await api.request(
        route: '/promo/company/token?token_id=${token['id']}',
        method: HttpMethod.delete,
      );
    } catch (e) {
      ErrorHandler.show(context, e);
    }

    await _load();
  }

  Future<void> _updatePromocode(Map<String, dynamic> promocode) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => UpdatePromocodePage(promocode: promocode),
      ),
    );

    await _load();
  }

  Future<void> _setTokenActive(
    Map<String, dynamic> token,
    bool isActive,
  ) async {
    try {
      await api.request(
        route:
            '/promo/company/token?token_id=${token['id']}&is_active=$isActive',
        method: HttpMethod.put,
      );
    } catch (e) {
      ErrorHandler.show(context, e);
    }

    await _load();
  }

  void _createPromocode() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => CreatePromocodePage()));

    await _load();
  }

  void _createToken() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CreateTokenPage(companyId: _company?['id']),
      ),
    );

    await _load();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      loading: _loading,
      child: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (_company != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _company!['name'],
                              style: Theme.of(context).textTheme.titleLarge,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 12),
                          FilledButton.icon(
                            style: FilledButton.styleFrom(
                              minimumSize: const Size(0, 50),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => UpdateCompanyProfileWidget(
                                    company: {'name': _company!['name']},
                                    onUpdated: _load,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit),
                            label: Text(context.l10n.update),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),
                      _field(context.l10n.id, _company!['id']),
                      _field(
                        context.l10n.created,
                        formatDate(_company!['created_at']),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 20),

            Row(
              textDirection: TextDirection.ltr,
              children: [
                FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(50, 50),
                    backgroundColor: Colors.green.shade100,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: _createToken,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 12),
                Text(
                  context.l10n.api_tokens,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),

            const SizedBox(height: 12),

            if (_tokens.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(context.l10n.no_tokens),
                ),
              ),

            ...(_tokens.toList()..sort(
                  (a, b) =>
                      (a['name'] as String).compareTo(b['name'] as String),
                ))
                .map(
                  (token) => TokenCard(
                    token: token,
                    onDelete: () => _deleteToken(token),
                    onActiveChanged: (value) => _setTokenActive(token, value),
                  ),
                ),

            const SizedBox(height: 20),

            Row(
              textDirection: TextDirection.ltr,
              children: [
                FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(50, 50),
                    backgroundColor: Colors.green.shade100,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: _createPromocode,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 12),
                Text(
                  context.l10n.promocodes,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),

            const SizedBox(height: 12),

            if (_promocodes.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(context.l10n.no_promocodes),
                ),
              ),

            ..._promocodes.map(
              (promo) => AdvancedPromocodeCard(
                promocode: promo,
                onEdit: () => _updatePromocode(promo),
                onDelete: () => _deletePromocode(promo),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
