import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

class AuthorizationService {
  Future<String?> get accessToken =>
      storage.read(key: 'access_token');

  Future<void> saveAccessToken(String token) =>
      storage.write(key: 'access_token', value: token);

  Future<String?> get refreshToken => storage.read(key: 'refresh_token');

  Future<void> saveRefreshToken(String token) =>
      storage.write(key: 'refresh_token', value: token);

  Future<void> logout() async {
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'refresh_token');
  }
}
