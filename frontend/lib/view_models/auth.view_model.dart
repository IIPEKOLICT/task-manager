import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/dtos/response/auth.dto.dart';
import 'package:frontend/repositories/auth.repository.dart';
import 'package:frontend/repositories/main.repository.dart';
import 'package:frontend/view_models/base/loadable.view_model.dart';
import 'package:frontend/view_models/base/page.view_model.dart';
import 'package:frontend/view_models/state/auth.state.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../dtos/request/create_user.dto.dart';
import '../enums/route.enum.dart';
import '../services/storage.service.dart';

@Injectable()
class AuthViewModel extends PageViewModel<AuthViewModel> with LoadableViewModel {
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
  }

  @override
  AuthViewModel copy(BuildContext context) {
    return AuthViewModel(context, _authState, _mainRepository, _authRepository, _storageService);
  }

  @override
  AuthViewModel create() {
    _onInit();
    return this;
  }

  String _email = '';
  String _password = '';
  String _firstName = '';
  String _lastName = '';

  bool get _isValidForLogin {
    return _email.isNotEmpty && _password.isNotEmpty;
  }

  bool get _isValidForRegister {
    return _email.isNotEmpty && _password.isNotEmpty && _firstName.isNotEmpty && _lastName.isNotEmpty;
  }

  String getEmail() => _email;
  String getPassword() => _password;
  String getFirstName() => _email;
  String getLastName() => _password;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setFirstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  void setLastName(String value) {
    _lastName = value;
    notifyListeners();
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
      toggleIsLoading();
      return notifyListeners();
    }

    if (isLoading) {
      _tryRefreshToken();
      return;
    }

    context.go(RouteEnum.home.value);
  }

  void _onBadConnection(exception) {
    onException(exception, message: 'Нет подключения к серверу');
    Future.delayed(const Duration(seconds: 2), () => SystemNavigator.pop(animated: true));
  }

  Future<void> _tryRefreshToken() async {
    try {
      AuthDto data = await _authRepository.refreshToken();
      toggleIsLoading();
      _authState.setUserData(data);
    } catch (e) {
      await _authState.reset();
    }
  }

  Future<void> _login() async {
    await _authState.setUserData(await _authRepository.login(_email, _password));
  }

  Future<void> _register() async {
    await _authState.setUserData(
      await _authRepository.register(
        CreateUserDto(
          _email,
          _password,
          _firstName,
          _lastName,
        ),
      ),
    );
  }

  Future<void> Function()? submitHandler(bool isRegister) {
    if ((isRegister && !_isValidForRegister) || (!isRegister && !_isValidForLogin)) return null;

    return () async {
      try {
        if (isRegister) {
          await _register();
        } else {
          await _login();
        }
      } catch (e) {
        onException(e, message: isRegister ? 'Ошибка регистрации' : 'Неверный E-mail или пароль');
      } finally {
        Navigator.of(context).pop();
      }
    };
  }

  @override
  void dispose() {
    _authState.isAuth$.unsubscribe(_isAuthSubscription);

    super.dispose();
  }
}
