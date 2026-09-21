import 'package:flutter/material.dart';
import 'package:promo/core/api/minio.dart';
import 'package:promo/pages/post_screen.dart';
import 'package:promo/shared/extensions/extract_max_discount.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/models/company.dart';
import 'package:promo/shared/models/promotion.dart';
import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/theme/app_strings.dart';
import 'package:promo/shared/widgets/menus/horizontal_selection.dart';
import 'package:promo/shared/widgets/paginated_list.dart';
import 'package:promo/shared/widgets/promotions/promo_banner.dart';
import 'package:promo/shared/widgets/promotions/promotions_service.dart';

class AdsPage extends StatefulWidget {
  const AdsPage({super.key, this.selectedTag, required this.companies});

  final PromotionTag? selectedTag;
  final List<Company> companies;

  @override
  State<AdsPage> createState() => _AdsPageState();
}

class _AdsPageState extends State<AdsPage> {
  late final PublicPromotionService _service;
  PromotionTag? _selectedTag;

  @override
  void initState() {
    super.initState();
    _selectedTag = widget.selectedTag;
    _service = PublicPromotionService(minio: MinioStorage());
  }

  @override
  Widget build(BuildContext context) {
    final tagItems = [
      SelectionItem(label: context.l10n.all, color: AppColors.accent),
      ...PromotionTag.values
          .where((tag) => tag != PromotionTag.deprecated)
          .map(
            (tag) => SelectionItem(
              label: promotionTagLabel(context, tag),
              color: tag.color,
            ),
          ),
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              context.l10n.ads,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),

          const SizedBox(height: 12),

          HorizontalSelection(
            items: tagItems,
            initialIndex: _selectedTag == null
                ? 0
                : PromotionTag.values.indexOf(_selectedTag!) + 1,
            onSelect: (index) {
              setState(() {
                _selectedTag = index == 0
                    ? null
                    : PromotionTag.values[index - 1];
              });
            },
          ),

          const SizedBox(height: 12),

          Expanded(
            child: PaginatedList<Promotion>(
              key: ValueKey(_selectedTag),
              pageSize: 10,
              loadPage: (page, limit) async {
                final news = await _service.getPromotions(
                  page: page,
                  limit: limit,
                  tag: _selectedTag,
                );

                return news.map((item) {
                  final company = widget.companies.cast<Company?>().firstWhere(
                    (company) => company?.id == item.companyId,
                    orElse: () => null,
                  );

                  item.companyName = company?.name ?? AppStrings.companyName;
                  return item;
                }).toList();
              },
              emptyWidget: Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Center(child: Text(context.l10n.no_promotions)),
              ),
              itemBuilder: (context, promotion) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: PromoBanner(
                    title: promotion.title,
                    discountLabel: extractMaxDiscount(promotion.title),
                    imageUrl: promotion.imageUrl,
                    tagValue: promotion.tag != null
                        ? promotionTagLabel(context, promotion.tag!)
                        : null,
                    tagColor: promotion.tag?.color,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PostPage(
                            id: promotion.id,
                            title: promotion.title,
                            description: promotion.description,
                            tag: promotionTagLabel(context, promotion.tag),
                            tagColor: promotion.tag?.color,
                            priority: promotion.priority,
                            createdAt: promotion.createdAt,
                            companyId: promotion.companyId,
                            companyName: promotion.companyName,
                            imageUrl: promotion.imageUrl,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
