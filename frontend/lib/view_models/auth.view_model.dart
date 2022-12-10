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
import '../services/storage.service.dart';

@Injectable()
class AuthViewModel extends BaseViewModel {
  final AuthState _authState;
  final MainRepository _mainRepository;
  final AuthRepository _authRepository;
  final StorageService _storageService;

  AuthViewModel(
    @factoryParam super.context,
    this._authState,
    this._mainRepository,
    this._authRepository,
    this._storageService,
  );

  @override
  void onInit() {
    _authState.isAuth$.subscribe(_isAuthSubscription);

    _onInit();
  }

  Future<void> _onInit() async {
    final String? token = await _storageService.getTokenOrNull();
    final String? userId = await _storageService.getUserIdOrNull();
    final bool hasConnection = await _mainRepository.healthCheck();

    if (!hasConnection) {
      return _onBadConnection(Exception());
    }

    _authState.setUserIdAndToken(userId, token);
  }

  void _isAuthSubscription(bool isAuth) {
    if (!isAuth) {
      return context.go(RouteEnum.login.value);
    }

    _tryRefreshToken();
  }

  void _onBadConnection(exception) {
    onException(exception, message: 'Нет подключения к серверу');
    Future.delayed(const Duration(seconds: 2), () => SystemNavigator.pop(animated: true));
  }

  Future<void> _tryRefreshToken() async {
    try {
      AuthDto data = await _authRepository.refreshToken();
      _authState.setUserData(data).then((_) => context.go(RouteEnum.home.value));
    } catch (e) {
      await _authState.reset();
    }
  }

  @override
  void dispose() {
    _authState.isAuth$.unsubscribe(_isAuthSubscription);

    super.dispose();
  }
}
