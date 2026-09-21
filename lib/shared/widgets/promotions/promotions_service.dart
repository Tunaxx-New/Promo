import 'package:promo/core/api/api.dart';
import 'package:promo/core/api/minio.dart';
import 'package:promo/shared/models/promotion.dart';
import 'package:promo/shared/theme/app_strings.dart';
import 'package:promo/shared/widgets/api_form/api_exception.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';

class PublicPromotionService {
  final MinioStorage minio;

  PublicPromotionService({required this.minio});

  Future<List<Promotion>> getPromotions({
    int limit = 10,
    int page = 1,
    PromotionTag? tag,
  }) async {
    try {
      final query = [
        'company_id=${AppStrings.companyId}',
        'page=$page',
        'limit=$limit',
        if (tag != null) 'tag=${tag.value}',
      ].join('&');

      final response = await api.request(
        route: '/promotions/?$query',
        method: HttpMethod.get,
      );

      final rows = List<Map<String, dynamic>>.from(response['data'] ?? []);

      return rows.map((item) {
        return Promotion.fromJson({
          ...item,
          'image_url': item['id'] != null
              ? minio.imageUrl('${item['id']}.png')
              : null,
        });
      }).toList();
    } on ApiException {
      rethrow;
    }
  }
}
