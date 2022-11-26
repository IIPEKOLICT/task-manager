import 'package:frontend/di/app.module.dart';
import 'package:frontend/dtos/response/auth.dto.dart';
import 'package:frontend/repositories/auth.repository.dart';
import 'package:frontend/view_models/base/base.view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../enums/route.enum.dart';
import '../services/storage.service.dart';

@Injectable()
class LoginViewModel extends BaseViewModel {
  LoginViewModel(@factoryParam super.context);

  final AuthRepository _authRepository = injector.get();
  final StorageService _storageService = injector.get();

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
      AuthDto data = await _authRepository.login(_email, _password);
      await _storageService.saveToken(data.token);
      _storageService.saveUserId(data.user.id).then((_) => context.go(RouteEnum.home.value));
    } catch (e) {
      onException('Неверный E-mail или пароль');
    } finally {
      notifyListeners();
    }
  }
}