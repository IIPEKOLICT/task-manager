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

  final Stream<bool> _hasInitialized$ = Stream(false);
  final Stream<bool> _isAuth$ = Stream(false);
  final Stream<User?> _user$ = Stream(null);

  Observable<bool> get hasInitialized$ {
    return _hasInitialized$;
  }

  Observable<bool> get isAuth$ {
    return _isAuth$;
  }

  Observable<User?> get user$ {
    return _user$;
  }

  bool get hasToken {
    return _token != null;
  }

  bool get hasUserId {
    return _userId != null;
  }

  String? getTokenOrNull() => _token;
  String? getUserIdOrNull() => _userId;
  String getUserId() => _userId ?? (throw Exception());
  User? getUserOrNull() => _user$.get();
  User getUser() => _user$.get() ?? (throw Exception());

  Future<void> setUserData(AuthDto value) async {
    _token = value.token;
    _userId = value.user.id;

    await _onChangeToken(value.token);
    await _onChangeUserId(value.user.id);

    _isAuth$.set(true);
    _user$.set(value.user);
  }

  void setUser(User value) => _user$.set(value);

  Future<void> _onInit() async {
    _token = await _storageService.getToken();
    _userId = await _storageService.getUserId();

    _hasInitialized$.set(true);
    _isAuth$.set(_token != null && _userId != null);
  }

  Future<void> reset() async {
    _token = null;
    _userId = null;

    await _storageService.removeToken();
    await _storageService.removeUserId();

    _isAuth$.set(false);
    _user$.set(null);
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
