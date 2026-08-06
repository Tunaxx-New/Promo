class MinioStorage {
  final String endpoint = 'http://46.8.31.215:9000';
  final String bucket = 'promotions';

  String imageUrl(String path) {
    return '$endpoint/$bucket/$path';
  }
}
