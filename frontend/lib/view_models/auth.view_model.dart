import 'package:flutter/foundation.dart';
import 'package:frontend/di/app.module.dart';
import 'package:frontend/dtos/response/auth.dto.dart';
import 'package:frontend/repositories/auth.repository.dart';
import 'package:frontend/view_models/base/base.view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../enums/route.enum.dart';
import '../models/user.dart';
import '../services/storage.service.dart';

@Injectable()
class AuthViewModel extends BaseViewModel {
  AuthViewModel(@factoryParam super.context) {
    _onInit(() => context.go(RouteEnum.login.value));
  }

  final AuthRepository _authRepository = injector.get();
  final StorageService _storageService = injector.get();
  
  String? _token;
  User? _user;
  bool _isLoaded = true;

  bool get isLoaded {
    return _isLoaded;
  }

  bool get isAuth {
    return _user != null;
  }

  String? getToken() => _token;
  User? getUser() => _user;

  void setAuthData(AuthDto data) {
    _user = data.user;
    _token = data.token;
    notifyListeners();
  }

  Future<void> logout(VoidCallback teleport) async {
    _user = null;
    _token = null;
    await _handleToken();
    notifyListeners();
    teleport();
  }

  Future<void> _onInit(VoidCallback teleport) async {
    String? token = await _storageService.getToken();
    String? userId = await _storageService.getUserId();

    if (token == null) {
      _clearState();
      _isLoaded = false;
      return teleport();
    }

    if (userId == null) {
      try {
        AuthDto data = await _authRepository.refreshToken();
        _user = data.user;
        _token = data.token;
        await _storageService.saveToken(data.token);
        await _storageService.saveUserId(data.user.id);
      } catch (e) {
        _clearState();
      } finally {
        _isLoaded = false;
        notifyListeners();
        teleport();
      }
    } else {
      _isLoaded = false;
    }
  }

  void _clearState() {
    _token = null;
    _user = null;
  }

  Future<void> _handleToken({String? token}) async {
    if (token == null) {
      await _storageService.removeToken();
    } else {
      await _storageService.saveToken(token);
    }
  }
}