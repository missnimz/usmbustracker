import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Localstorage {
  static const _storage = FlutterSecureStorage();
  static const _token = 'token';
  static const _eui = "eui";

  static Future savetoken(String token) async {
    await _storage.write(key: _token, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _token);
  }

  static Future saveEUI(String eui) async {
    await _storage.write(key: _eui, value: eui);
  }

  static Future<String?> geteui() async {
    return await _storage.read(key: _eui);
  }
}
