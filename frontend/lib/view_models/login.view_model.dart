import 'package:frontend/repositories/auth.repository.dart';
import 'package:frontend/view_models/base/base.view_model.dart';
import 'package:frontend/view_models/state/auth.state.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../enums/route.enum.dart';

@Injectable()
class LoginViewModel extends BaseViewModel {
  final AuthState _authState;
  final AuthRepository _authRepository;

  LoginViewModel(@factoryParam super.context, this._authState, this._authRepository) {
    _authState.isAuth$.subscribe(_isAuthSubscription);
  }

  void _isAuthSubscription(bool isAuth) {
    notifyListeners();
    context.go((isAuth ? RouteEnum.home : RouteEnum.login).value);
  }

  String _email = '';
  String _password = '';

  bool get isValid {
    return _email.isNotEmpty && _password.isNotEmpty;
  }

  String getEmail() => _email;
  String getPassword() => _password;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future<void> login() async {
    try {
      await _authState.setUserData(await _authRepository.login(_email, _password));
    } catch (e) {
      onException(e, message: 'Неверный E-mail или пароль');
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _authState.isAuth$.unsubscribe(_isAuthSubscription);

    super.dispose();
  }
}