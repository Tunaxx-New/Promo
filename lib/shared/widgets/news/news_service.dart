import 'package:promo/core/api/api.dart';
import 'package:promo/core/api/minio.dart';
import 'package:promo/shared/models/news.dart';
import 'package:promo/shared/models/promotion.dart';
import 'package:promo/shared/theme/app_strings.dart';
import 'package:promo/shared/widgets/api_form/api_exception.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';

class PublicNewsService {
  final MinioStorage minio;

  PublicNewsService({required this.minio});

  Future<List<News>> getNews({
    int limit = 10,
    int page = 1,
    NewsTag? tag,
  }) async {
    try {
      final query = [
        'company_id=${AppStrings.companyId}',
        'page=$page',
        'limit=$limit',
        if (tag != null) 'tag=${tag.value}',
      ].join('&');

      final response = await api.request(
        route: '/promotions/news?$query',
        method: HttpMethod.get,
      );

      final rows = List<Map<String, dynamic>>.from(response['data'] ?? []);

      return rows.map((item) {
        return News.fromJson({
          ...item,
          'image_url': item['id'] != null
              ? minio.imageUrlFromBucket('news', '${item['id']}.png')
              : null,
        });
      }).toList();
    } on ApiException {
      rethrow;
    }
  }
}
