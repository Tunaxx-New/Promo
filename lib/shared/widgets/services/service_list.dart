import 'package:flutter/material.dart';
import 'package:promo/core/api/api.dart';
import 'package:promo/core/api/minio.dart';
import 'package:promo/shared/models/service.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';
import 'package:promo/shared/widgets/error_handler.dart';
import 'package:promo/shared/widgets/services/service_banner.dart';

class ServiceList extends StatefulWidget {
  const ServiceList({super.key, required this.companyId, this.onTap});

  final String companyId;
  final ValueChanged<Service>? onTap;

  @override
  State<ServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  final _minio = MinioStorage();

  final List<Service> _services = [];

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    if (_services.isEmpty && !_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.separated(
      itemCount: _services.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        if (index == _services.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final service = _services[index];

        return ServiceBanner(
          service: service,
          onTap: widget.onTap == null ? null : () => widget.onTap!(service),
        );
      },
    );
  }
}
