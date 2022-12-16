import 'package:injectable/injectable.dart';

import '../../dtos/response/auth.dto.dart';
import '../../models/user.dart';
import '../../services/storage.service.dart';
import '../shared/observable.dart';
import '../shared/stream.dart';

@LazySingleton()
class AuthState {
  final StorageService _storageService;

  AuthState(this._storageService);

  String? _token;
  String? _userId;

  final Stream<bool> _isAuth$ = Stream(false);
  final Stream<User?> _user$ = Stream(null);

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

  void setUserIdAndToken(String? userId, String? token) {
    _token = token;
    _userId = userId;
    _isAuth$.set(_token != null && _userId != null);
  }

  void setUser(User value) => _user$.set(value);

  Future<void> reset() async {
    _token = null;
    _userId = null;

    await _storageService.removeToken();
    await _storageService.removeUserId();

    _isAuth$.set(false);
    _user$.set(null);
  }

  Future<void> _onChangeToken(String? value) async {
    if (value != null) {
      await _storageService.saveToken(value);
    }
  }

  Future<void> _onChangeUserId(String? value) async {
    if (value != null) {
      await _storageService.saveUserId(value);
    }
  }
}
