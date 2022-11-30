import 'package:frontend/di/app.module.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../storage.service.dart';

@LazySingleton(as: StorageService)
class StorageServiceImpl extends StorageService {
  final String _tokenKey = 'TOKEN';
  final String _userIdKey = 'USER_ID';

  final Future<SharedPreferences> _sharedPreferences = injector.getAsync();

  @override
  Future<String?> getToken() async {
    return (await _sharedPreferences).getString(_tokenKey);
  }

  @override
  Future<void> saveToken(String token) async {
    await (await _sharedPreferences).setString(_tokenKey, token);
  }

  @override
  Future<void> removeToken() async {
    await (await _sharedPreferences).remove(_tokenKey);
  }

  @override
  Future<String?> getUserId() async {
    return (await _sharedPreferences).getString(_userIdKey);
  }

  @override
  Future<void> saveUserId(String userId) async {
    await (await _sharedPreferences).setString(_userIdKey, userId);
  }

  @override
  Future<void> removeUserId() async {
    await (await _sharedPreferences).remove(_userIdKey);
  }
}