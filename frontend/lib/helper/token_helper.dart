import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenHelper {
  final secureStorage = const FlutterSecureStorage();

  void saveToken(String value) async {
    await secureStorage.write(key: 'token', value: value);
  }

  Future<String> getToken() async {
    String? result = await secureStorage.read(key: 'token');
    return result ?? '';
  }
}
