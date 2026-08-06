import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

class UserService {
  Future<String?> get userId => storage.read(key: 'user_id');
  Future<void> saveUserId(String userId) =>
      storage.write(key: 'user_id', value: userId);

  Future<String?> get name => storage.read(key: 'name');
  Future<void> saveName(String? name) async {
    if (name == null) {
      await storage.delete(key: 'name');
      return;
    }

    await storage.write(key: 'name', value: name);
  }
}
