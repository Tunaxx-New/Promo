class ApiException implements Exception {
  final int statusCode;
  String? message;

  ApiException({
    required this.statusCode,
    required this.message,
  });

  @override
  String toString() {
    return "$statusCode $message";
  }
}