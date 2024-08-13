import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecuredStorage{
  static const _storage = FlutterSecureStorage();
  static const _token = 'token';

  Future<void> setToken(String newToken) async{
    await _storage.write(key: _token, value: newToken);
  }

  Future<String?> getToken() async => await _storage.read(key: _token);

  Future<void> deleteToken() async => await _storage.delete(key: _token);

}