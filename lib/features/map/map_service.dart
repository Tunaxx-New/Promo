import 'package:promo/core/api/api.dart';
import 'package:promo/shared/models/map_point.dart';
import 'package:promo/shared/theme/app_strings.dart';
import 'package:promo/shared/widgets/api_form/api_exception.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';

class PublicMapService {
  Future<List<MapPoint>> getPoints() async {
    try {
      final response = await api.request(
        route: '/promotions/map_points?company_id=${AppStrings.companyId}',
        method: HttpMethod.get,
      );

      final rows = List<Map<String, dynamic>>.from(response['data'] ?? []);

      return rows.map(MapPoint.fromJson).toList();
    } on ApiException {
      rethrow;
    }
  }
}
