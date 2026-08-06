import 'dart:math';

String generateToken([int length = 64]) {
  const chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random.secure();

  return List.generate(
    length,
    (_) => chars[random.nextInt(chars.length)],
  ).join();
}
