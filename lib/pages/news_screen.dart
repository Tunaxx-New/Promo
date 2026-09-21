import 'package:flutter/material.dart';
import 'package:promo/core/api/minio.dart';
import 'package:promo/pages/post_screen.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/formatters/form_date.dart';
import 'package:promo/shared/models/company.dart';
import 'package:promo/shared/models/news.dart';
import 'package:promo/shared/models/promotion.dart';
import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/theme/app_strings.dart';
import 'package:promo/shared/widgets/menus/horizontal_selection.dart';
import 'package:promo/shared/widgets/news/news_banner.dart';
import 'package:promo/shared/widgets/news/news_service.dart';
import 'package:promo/shared/widgets/paginated_list.dart';
import 'package:promo/shared/widgets/promotions/promo_banner.dart';
import 'package:promo/shared/widgets/promotions/promotions_service.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key, required this.companies});

  final List<Company> companies;

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late final PublicNewsService _service;
  NewsTag? _selectedTag;

  @override
  void initState() {
    super.initState();
    _service = PublicNewsService(minio: MinioStorage());
  }

  @override
  Widget build(BuildContext context) {
    final tagItems = [
      SelectionItem(label: context.l10n.all, color: AppColors.accent),
      ...NewsTag.values
          .where((tag) => tag != NewsTag.deprecated)
          .map(
            (tag) => SelectionItem(
              label: newsTagLabel(context, tag),
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
              context.l10n.news,
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
            onSelect: (index) {
              setState(() {
                _selectedTag = index == 0 ? null : NewsTag.values[index - 1];
              });
            },
          ),

          const SizedBox(height: 12),

          Expanded(
            child: PaginatedList<News>(
              key: ValueKey(_selectedTag),
              pageSize: 10,
              loadPage: (page, limit) async {
                final news = await _service.getNews(
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
                child: Center(child: Text(context.l10n.no_news)),
              ),
              itemBuilder: (context, news) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Column(
                    children: [
                      Container(height: 1, color: AppColors.border),
                      const SizedBox(height: 8),
                      NewsBanner(
                        title: news.title,
                        date: formatDate(context, news.createdAt.toString()),
                        imageUrl: news.imageUrl,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PostPage(
                                id: news.id,
                                title: news.title,
                                description: news.description,
                                tag: newsTagLabel(context, news.tag),
                                tagColor: news.tag?.color,
                                priority: news.priority,
                                createdAt: news.createdAt,
                                companyId: news.companyId,
                                companyName: news.companyName,
                                imageUrl: news.imageUrl,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                    ],
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
