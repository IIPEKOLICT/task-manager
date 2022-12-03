import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/repositories/user.repository.dart';
import 'package:frontend/view_models/base/base.view_model.dart';
import 'package:frontend/view_models/state/auth.state.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class EditUserDialogViewModel extends BaseViewModel {
  final AuthState _authState;
  final UserRepository _userRepository;

  EditUserDialogViewModel(@factoryParam super.context, this._userRepository, this._authState);

  String _email = '';
  String _password = '';
  String _firstName = '';
  String _lastName = '';

  bool get isCredentialsValid {
    return _email.isNotEmpty || _password.isNotEmpty;
  }

  bool get isInfoValid {
    return _firstName.isNotEmpty && _lastName.isNotEmpty;
  }

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

  Future<void> _update(Future<User> Function() callback) async {
    try {
      _authState.setUser(await callback());
    } catch (e) {
      onException(e);
    } finally {
      Navigator.of(context).pop();
    }
  }

  Future<void> updateCredentialsHandler() {
    return _update(() async => _userRepository.updateCredentials(_authState.getUserId(), _email, _password));
  }

  Future<void> updateInfoHandler() {
    return _update(() async => _userRepository.updateInfo(_authState.getUserId(), _firstName, _lastName));
  }
}
