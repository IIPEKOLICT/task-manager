import 'package:flutter/foundation.dart';
import 'package:frontend/di/app.module.dart';
import 'package:frontend/dtos/response/auth.dto.dart';
import 'package:frontend/repositories/auth.repository.dart';
import 'package:frontend/view_models/base/base.view_model.dart';
import 'package:frontend/view_models/state/auth.state.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../enums/route.enum.dart';
import '../models/user.dart';

@Injectable()
class AuthViewModel extends BaseViewModel {
  AuthViewModel(@factoryParam super.context) {
    if (!_authState.isAuth) {
      _onInit(() => context.go(RouteEnum.login.value));
    }
  }

  final AuthState _authState = injector.get();
  final AuthRepository _authRepository = injector.get();

  bool _isLoaded = false;

  bool get isLoaded {
    return _isLoaded;
  }

  bool get isAuth {
    return _authState.isAuth;
  }

  String? getToken() => _authState.getToken();
  User? getUser() => _authState.getUser();

  Future<void> logout(VoidCallback teleport) async {
    await _authState.reset();
    notifyListeners();
    teleport();
  }

  Future<void> _onInit(VoidCallback teleport) async {
    _isLoaded = true;
    await _authState.onInit();

    if (!_authState.hasToken) {
      _isLoaded = false;
      return teleport();
    }

    if (!_authState.hasUserId) {
      try {
        AuthDto data = await _authRepository.refreshToken();
        await _authState.setUserData(data);
      } catch (e) {
        await _authState.reset();
      } finally {
        _isLoaded = false;
        notifyListeners();
        teleport();
      }
    } else {
      _isLoaded = false;
    }
  }
}