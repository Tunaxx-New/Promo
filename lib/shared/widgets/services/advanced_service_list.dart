import 'package:flutter/material.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/formatters/currency_name.dart';
import 'package:promo/shared/models/service.dart';

class AdvancedServiceList extends StatefulWidget {
  const AdvancedServiceList({super.key, required this.servicesNotifier});

  final ValueNotifier<List<Service>> servicesNotifier;

  @override
  State<AdvancedServiceList> createState() => _AdvancedServiceListState();
}

class _AdvancedServiceListState extends State<AdvancedServiceList> {
  final _searchController = TextEditingController();

  String _searchQuery = '';

  @override
  void initState() {
    super.initState();

    widget.servicesNotifier.addListener(_onServicesChanged);

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  void _onServicesChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    widget.servicesNotifier.removeListener(_onServicesChanged);
    _searchController.dispose();
    super.dispose();
  }

  List<Service> get _filteredServices {
    if (_searchQuery.isEmpty) {
      return widget.servicesNotifier.value;
    }

    return widget.servicesNotifier.value.where((service) {
      return service.name.toLowerCase().contains(_searchQuery) ||
          (service.priceType?.toLowerCase().contains(_searchQuery) ?? false) ||
          service.description.toLowerCase().contains(_searchQuery) ||
          (service.priceType?.toLowerCase().contains(_searchQuery) ?? false) ||
          (service.companyName?.toLowerCase().contains(_searchQuery) ?? false);
    }).toList();
  }

  Map<String, Map<String, List<Service>>> _groupServices(
    List<Service> services,
  ) {
    final result = <String, Map<String, List<Service>>>{};

    for (final service in services) {
      final companyName = service.companyName?.isNotEmpty == true
          ? service.companyName!
          : 'Без компании';

      final priceType = service.priceType?.isNotEmpty == true
          ? service.priceType!
          : 'Услуги из скриншотов приложения';

      result
          .putIfAbsent(companyName, () => {})
          .putIfAbsent(priceType, () => [])
          .add(service);
    }

    return result;
  }

  void _showServiceDetails(BuildContext context, Service service) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ServiceDetails(service: service),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.servicesNotifier.value.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final filteredServices = _filteredServices;
    final grouped = _groupServices(filteredServices);

    return Column(
      children: [
        // SEARCH
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Поиск услуг',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      onPressed: _searchController.clear,
                      icon: const Icon(Icons.clear),
                    )
                  : null,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        Expanded(
          child: filteredServices.isEmpty
              ? const Center(child: Text('Ничего не найдено'))
              : ListView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  children: [
                    for (final companyEntry in grouped.entries) ...[
                      // COMPANY
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 10),
                        child: Text(
                          companyEntry.key,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // PRICE TYPES
                      for (final priceTypeEntry in companyEntry.value.entries)
                        Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ExpansionTile(
                            initiallyExpanded: false,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            collapsedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: Text(
                              priceTypeEntry.key,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              '${priceTypeEntry.value.length} услуг',
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.55),
                              ),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                child: Column(
                                  children: [
                                    for (final service in priceTypeEntry.value)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 6,
                                        ),
                                        child: _ServiceTile(
                                          service: service,
                                          onTap: () => _showServiceDetails(
                                            context,
                                            service,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ],
                ),
        ),
      ],
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({required this.service, required this.onTap});

  final Service service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  service.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '+${service.bonusCount}',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 2),

              Icon(
                Icons.chevron_right,
                size: 20,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceDetails extends StatelessWidget {
  const _ServiceDetails({required this.service});

  final Service service;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 650),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                service.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              if (service.priceType?.isNotEmpty == true)
                _InfoRow(
                  icon: Icons.inventory_2_outlined,
                  title: 'Наименование',
                  value: service.priceType!,
                ),

              if (service.description.isNotEmpty)
                _InfoRow(
                  icon: Icons.description_outlined,
                  title: 'Описание',
                  value: service.description,
                ),

              if (service.priceType?.isNotEmpty == true)
                _InfoRow(
                  icon: Icons.sell_outlined,
                  title: 'Тип цены',
                  value: service.priceType!,
                ),

              if (service.price != null)
                _InfoRow(
                  icon: Icons.payments_outlined,
                  title: 'Цена',
                  value: '${service.price}',
                ),

              if (service.currency != null)
                _InfoRow(
                  icon: Icons.currency_exchange,
                  title: 'Валюта',
                  value: currencyName(service.currency),
                ),

              const SizedBox(height: 8),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '+${service.bonusCount} ${context.l10n.bonusov}',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 21, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
