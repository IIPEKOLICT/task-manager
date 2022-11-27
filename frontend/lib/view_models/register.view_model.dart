import 'package:frontend/di/app.module.dart';
import 'package:frontend/dtos/request/create_user.dto.dart';
import 'package:frontend/dtos/response/auth.dto.dart';
import 'package:frontend/enums/route.enum.dart';
import 'package:frontend/repositories/auth.repository.dart';
import 'package:frontend/view_models/base/base.view_model.dart';
import 'package:frontend/view_models/state/auth.state.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RegisterViewModel extends BaseViewModel {
  RegisterViewModel(@factoryParam super.context);

  final AuthState _authState = injector.get();
  final AuthRepository _authRepository = injector.get();

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
      AuthDto data = await _authRepository.register(
        CreateUserDto(_email, _password, _firstName, _lastName)
      );

      _authState.setUserData(data).then((_) => context.go(RouteEnum.home.value));
    } catch (e) {
      onException(e, message: 'Ошибка регистрации');
    } finally {
      notifyListeners();
    }
  }
}