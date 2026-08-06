import 'package:promo/core/api/api.dart';
import 'package:promo/core/api/minio.dart';
import 'package:promo/shared/widgets/api_form/api_exception.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';

class PublicPromotionService {
  final MinioStorage minio;

  PublicPromotionService({required this.minio});

  Future<List<Map<String, dynamic>>> getPromotions({
    int limit = 10,
    int page = 1,
  }) async {
    try {
      final response = await api.request(
        route: '/promotions?page=$page&limit=$limit',
        method: HttpMethod.get,
      );

      final rows = List<Map<String, dynamic>>.from(response['data'] ?? []);

      return rows.map((item) {
        final imagePath = '${item['id']}.png';

        return {
          ...item,
          'image_url': item['id'] != null ? minio.imageUrl(imagePath) : null,
        };
      }).toList();
    } on ApiException {
      rethrow;
    }
  }
}
