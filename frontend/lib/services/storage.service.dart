import 'package:frontend/di/app.module.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton()
class StorageService {
  final String _tokenKey = 'TOKEN';
  final String _userIdKey = 'USER_ID';

  final Future<SharedPreferences> _sharedPreferences = injector.getAsync();

  Future<String?> getToken() async {
    return (await _sharedPreferences).getString(_tokenKey);
  }

  Future<void> saveToken(String token) async {
    await (await _sharedPreferences).setString(_tokenKey, token);
  }

  Future<void> removeToken() async {
    await (await _sharedPreferences).remove(_tokenKey);
  }

  Future<String?> getUserId() async {
    return (await _sharedPreferences).getString(_userIdKey);
  }

  Future<void> saveUserId(String userId) async {
    await (await _sharedPreferences).setString(_userIdKey, userId);
  }

  Future<void> removeUserId() async {
    await (await _sharedPreferences).remove(_userIdKey);
  }
}