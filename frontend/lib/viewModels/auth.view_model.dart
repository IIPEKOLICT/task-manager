import 'package:flutter/foundation.dart';
import 'package:frontend/di/app.module.dart';
import 'package:frontend/dtos/auth.dto.dart';
import 'package:frontend/repositories/auth.repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

@LazySingleton()
class AuthViewModel extends ChangeNotifier {
  final Future<SharedPreferences> sharedPreferences = injector.getAsync();
  final AuthRepository authRepository = injector.get();
  
  String? _token;
  User? _user;
  String _email = '';
  String _password = '';

  bool get isAuth {
    return _user != null;
  }

  String? getToken() => _token;
  User? getUser() => _user;
  String getEmail() => _email;
  String getPassword() => _password;

  setToken(String? token) async {
    _token = token;
    await _handleToken(token);
    notifyListeners();
  }

  setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  login() async {
    AuthDto data = await authRepository.login(_email, _password);
    _user = data.user;
    _token = data.token;
    _clearFormState();
    notifyListeners();
  }

  _clearFormState() {
    _email = '';
    _password = '';
  }
  
  _handleToken(String? token) async {
    try {
      if (token == null) {
        await (await sharedPreferences).remove('TOKEN');
      } else {
        await (await sharedPreferences).setString('TOKEN', token);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Shared preferences not initialized yet');
      }
    }
  }
}