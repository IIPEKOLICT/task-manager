import 'package:frontend/dtos/request/create_user.dto.dart';
import 'package:frontend/repositories/auth.repository.dart';
import 'package:frontend/view_models/base/base.view_model.dart';
import 'package:frontend/view_models/state/auth.state.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../enums/route.enum.dart';

@Injectable()
class RegisterViewModel extends BaseViewModel {
  final AuthState _authState;
  final AuthRepository _authRepository;

  RegisterViewModel(
    @factoryParam super.context,
    this._authState,
    this._authRepository,
  );

  @override
  void onInit() {
    _authState.isAuth$.subscribe(_isAuthSubscription);
  }

  void _isAuthSubscription(bool isAuth) {
    notifyListeners();
    context.go((isAuth ? RouteEnum.home : RouteEnum.login).value);
  }

  String _email = '';
  String _password = '';
  String _firstName = '';
  String _lastName = '';

  bool get isValid {
    return _email.isNotEmpty && _password.isNotEmpty && _firstName.isNotEmpty && _lastName.isNotEmpty;
  }

  String getEmail() => _email;
  String getPassword() => _password;
  String getFirstName() => _email;
  String getLastName() => _password;

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
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

  Future<void> onSubmit() async {
    try {
      await _authState
          .setUserData(await _authRepository.register(CreateUserDto(_email, _password, _firstName, _lastName)));
    } catch (e) {
      onException(e, message: 'Ошибка регистрации');
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
