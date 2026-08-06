import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:promo/core/api/api.dart';
import 'package:promo/features/promocodes/widgets/promocode_card.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';
import 'package:promo/shared/widgets/error_handler.dart';
import 'package:promo/shared/widgets/menus/toggle_menu.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PromocodesPage extends StatefulWidget {
  final String? activatedPromocodeId;

  const PromocodesPage({super.key, this.activatedPromocodeId});

  @override
  State<PromocodesPage> createState() => _PromocodesPageState();
}

class _PromocodesPageState extends State<PromocodesPage> {
  int _selected = 0;
  final ItemScrollController _scrollController = ItemScrollController();
  bool _loading = true;

  List<dynamic> _promocodes = [];

  @override
  void initState() {
    super.initState();
    _loadPromocodes();
  }

  @override
  void didUpdateWidget(covariant PromocodesPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.activatedPromocodeId != widget.activatedPromocodeId &&
        widget.activatedPromocodeId != null) {
      _loadPromocodes();
    }
  }

  Future<void> _loadPromocodes() async {
    setState(() {
      _loading = true;
    });

    try {
      final response = await api.request(
        route: '/promo/promocode/my',
        method: HttpMethod.get,
      );

      _promocodes = List<dynamic>.from(response['data']);

      setState(() {});

      if (widget.activatedPromocodeId != null) {
        final promocode = _promocodes.cast<Map<String, dynamic>?>().firstWhere(
          (p) =>
              p?['promocode']['id'].toString() == widget.activatedPromocodeId,
          orElse: () => null,
        );

        if (promocode != null) {
          final userPromocode =
              promocode['user_promocode'] as Map<String, dynamic>? ?? {};

          final isUsed = userPromocode['is_used'] == true;

          setState(() {
            _selected = isUsed ? 1 : 0;
          });

          WidgetsBinding.instance.addPostFrameCallback((_) {
            final filtered = _promocodes.where((e) {
              final user = e['user_promocode'] as Map<String, dynamic>? ?? {};

              return _selected == 0
                  ? user['is_used'] != true
                  : user['is_used'] == true;
            }).toList();

            final index = filtered.indexWhere(
              (p) =>
                  p['promocode']['id'].toString() ==
                  widget.activatedPromocodeId,
            );

            if (index != -1) {
              _scrollController.scrollTo(
                index: index,
                duration: const Duration(milliseconds: 600),
              );
            }
          });
        }
      }
    } catch (e) {
      ErrorHandler.show(context, e);
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final promocodes = _promocodes.where((e) {
      final userPromocode = e['user_promocode'] as Map<String, dynamic>? ?? {};

      return _selected == 0
          ? userPromocode['is_used'] != true
          : userPromocode['is_used'] == true;
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: RefreshIndicator(
        onRefresh: _loadPromocodes,
        child: Column(
          children: [
            ToggleMenu(
              selectedIndex: _selected,
              options: [
                context.l10n.promocodesActive,
                context.l10n.promocodesUsed,
              ],
              onChanged: (value) {
                setState(() => _selected = value);
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: promocodes.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        Center(child: Text(context.l10n.promocodesEmpty)),
                      ],
                    )
                  : ScrollablePositionedList.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemScrollController: _scrollController,
                      itemCount: promocodes.length,
                      itemBuilder: (_, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: PromocodeCard(data: promocodes[index]),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
