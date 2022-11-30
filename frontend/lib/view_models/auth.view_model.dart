import 'dart:async';

import 'package:flutter/services.dart';
import 'package:frontend/dtos/response/auth.dto.dart';
import 'package:frontend/repositories/auth.repository.dart';
import 'package:frontend/repositories/main.repository.dart';
import 'package:frontend/view_models/base/base.view_model.dart';
import 'package:frontend/view_models/state/auth.state.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../enums/route.enum.dart';
import '../models/user.dart';

@Injectable()
class AuthViewModel extends BaseViewModel {
  final AuthState _authState;
  final MainRepository _mainRepository;
  final AuthRepository _authRepository;

  AuthViewModel(
    @factoryParam super.context,
    this._authState,
    this._mainRepository,
    this._authRepository
  ) {
    _authState.hasInitialized$.subscribe(_hasInitializedSubscription);
    _authState.isAuth$.subscribe(_isAuthSubscription);
  }

  void _isAuthSubscription(bool isAuth) {
    notifyListeners();

    if (_authState.hasInitialized$.get() && !_isLoading) {
      context.go((isAuth ? RouteEnum.home : RouteEnum.login).value);
    }
  }

  void _hasInitializedSubscription(bool hasInitialized) {
    if (hasInitialized) {
      _isLoading = true;
      notifyListeners();

      _mainRepository.healthCheck()
        .then((bool hasConnection) {
          if (!hasConnection) {
            _onBadConnection(Exception());
            return;
          }

          if (!_authState.isAuth$.get()) {
            _isLoading = false;
            _authState.reset();
            return notifyListeners();
          }

          _tryRefreshToken();
        })
        .catchError(_onBadConnection);
    }
  }

  FutureOr<void> _onBadConnection(exception) {
    _isLoading = false;
    onException(exception, message: 'Нет подключения к серверу');
    notifyListeners();
    Future.delayed(const Duration(seconds: 2), () => SystemNavigator.pop(animated: true));
  }

  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  bool get isAuth {
    return _authState.isAuth$.get();
  }

  String? getToken() => _authState.getToken();
  User? getUser() => _authState.getUser();

  void logout() {
    _authState.reset();
  }

  Future<void> _tryRefreshToken() async {
    try {
      AuthDto data = await _authRepository.refreshToken();
      await _authState.setUserData(data);
    } catch (e) {
      await _authState.reset();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _authState.hasInitialized$.unsubscribe(_hasInitializedSubscription);
    _authState.isAuth$.unsubscribe(_isAuthSubscription);

    super.dispose();
  }
}