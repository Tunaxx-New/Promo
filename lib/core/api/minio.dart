
class MinioStorage {
  static const String endpoint = String.fromEnvironment('API_MINIO_URL', defaultValue: 'http://localhost:9000');
  final String bucket = 'promotions';

  String imageUrl(String path) {
    return '$endpoint/$bucket/$path';
  }

    String imageUrlFromBucket(String bucket_, String path) {
    return '$endpoint/$bucket_/$path';
  }
}
