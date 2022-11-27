import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../di/app.module.dart';
import '../../dtos/response/auth.dto.dart';
import '../../models/user.dart';
import '../../services/storage.service.dart';

@LazySingleton()
class AuthState extends ChangeNotifier {
  AuthState() {
    onInit();
  }

  final StorageService _storageService = injector.get();
  
  String? _token;
  String? _userId;
  User? _user;

  String? get userId {
    return _user?.id;
  }

  bool get isAuth {
    return _user != null && _token != null;
  }

  bool get hasToken {
    return _token != null;
  }

  bool get hasUserId {
    return _userId != null;
  }

  String? getToken() => _token;
  String? getUserId() => _userId;
  User? getUser() => _user;

  Future<void> setUserData(AuthDto value) async {
    _token = value.token;
    _user = value.user;
    _userId = value.user.id;

    await _onChangeToken(value.token);
    await _onChangeUserId(value.user.id);
  }

  Future<void> onInit() async {
    _token = await _storageService.getToken();
    _userId = await _storageService.getUserId();
  }

  Future<void> reset() async {
    _token = null;
    _user = null;
    _userId = null;

    await _storageService.removeToken();
    await _storageService.removeUserId();
  }

  Future<void> _onChangeToken(String? token) async {
    if (token == null) {
      await _storageService.removeToken();
    } else {
      await _storageService.saveToken(token);
    }
  }

  Future<void> _onChangeUserId(String? token) async {
    if (token == null) {
      await _storageService.removeUserId();
    } else {
      await _storageService.saveUserId(token);
    }
  }
}