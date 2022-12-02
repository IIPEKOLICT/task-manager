import 'package:injectable/injectable.dart';

import '../../dtos/response/auth.dto.dart';
import '../../models/user.dart';
import '../../services/storage.service.dart';
import 'base/observable.dart';
import 'base/stream.dart';

@LazySingleton()
class AuthState {
  final StorageService _storageService;

  AuthState(this._storageService) {
    _onInit();
  }

  String? _token;
  String? _userId;
  User? _user;

  final Stream<bool> _hasInitialized$ = Stream(false);
  final Stream<bool> _isAuth$ = Stream(false);

  Observable<bool> get hasInitialized$ {
    return _hasInitialized$;
  }

  Observable<bool> get isAuth$ {
    return _isAuth$;
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

    _isAuth$.set(true);
  }

  Future<void> _onInit() async {
    _token = await _storageService.getToken();
    _userId = await _storageService.getUserId();

    _hasInitialized$.set(true);
    _isAuth$.set(_token != null && _userId != null);
  }

  Future<void> reset() async {
    _token = null;
    _user = null;
    _userId = null;

    await _storageService.removeToken();
    await _storageService.removeUserId();

    _isAuth$.set(false);
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
