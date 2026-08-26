import 'package:flutter_dotenv/flutter_dotenv.dart';

class MinioStorage {
  final String endpoint = dotenv.env['API_MINIO_URL'] ?? 'http://localhost:9000';
  final String bucket = 'promotions';

  String imageUrl(String path) {
    return '$endpoint/$bucket/$path';
  }

    String imageUrlFromBucket(String bucket_, String path) {
    return '$endpoint/$bucket_/$path';
  }
}
