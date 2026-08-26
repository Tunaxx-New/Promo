import 'package:flutter/material.dart';
import 'package:promo/core/api/minio.dart';
import 'package:promo/features/home/widgets/promotion_card.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/models/company.dart';
import 'package:promo/shared/widgets/error_handler.dart';
import 'package:promo/shared/widgets/promotions/promotions_service.dart';

class HomePage extends StatefulWidget {
  final List<Company> companies;
  final Future<void> Function()? onRefresh;

  const HomePage({super.key, required this.companies, this.onRefresh});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PublicPromotionService _service;

  bool _loading = false;
  bool _hasMore = true;
  int _offset = 0;

  List<Map<String, dynamic>> _promotions = [];

  final ScrollController _scrollController = ScrollController();

  static const int _limit = 10;
  int _page = 1;

  @override
  void initState() {
    super.initState();

    _service = PublicPromotionService(minio: MinioStorage());

    _scrollController.addListener(_onScroll);

    _loadMore();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_loading || !_hasMore) return;

    setState(() {
      _loading = true;
    });

    try {
      final data = await _service.getPromotions(page: _page, limit: 10);

      setState(() {
        _promotions.addAll(data);
        _page++;

        if (data.length < 10) {
          _hasMore = false;
        }
      });
    } catch (e) {
      if (!mounted) return;
      ErrorHandler.show(context, e);
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _loadPromotions() async {
    try {
      final data = await _service.getPromotions();

      if (!mounted) return;

      setState(() {
        _promotions = data;
        _loading = false;
      });
    } catch (e) {
      print('Failed to load promotions: $e');

      if (!mounted) return;

      setState(() {
        _loading = false;
      });
    } finally {
      await widget.onRefresh?.call();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    for (final promotion in _promotions) {
      Company? company;

      for (final item in widget.companies) {
        if (item.id == promotion['company_id']) {
          company = item;
          break;
        }
      }
      
      promotion['company_name'] = company?.name ?? '-';
    }

    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: _loadPromotions,
            child: _promotions.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: 200),
                      Center(child: Text(context.l10n.no_promotions)),
                    ],
                  )
                : ListView.builder(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: _promotions.length + (_hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _promotions.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      return PromotionCard(promotion: _promotions[index]);
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
