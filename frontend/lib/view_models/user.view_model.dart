import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/enums/route.enum.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/view_models/state/auth.state.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../repositories/user.repository.dart';
import '../services/file.service.dart';
import 'base/page.view_model.dart';

@Injectable()
class UserViewModel extends PageViewModel<UserViewModel> {
  final AuthState _authState;
  final UserRepository _userRepository;
  final FileService _fileService;

  UserViewModel(
    @factoryParam super.context,
    this._authState,
    this._userRepository,
    this._fileService,
  );

  @override
  void onInit() {
    _authState.user$.subscribe(_userSubscriber, lazy: false);
  }

  @override
  UserViewModel create() {
    _onInit();
    return this;
  }

  String _email = '';
  String _password = '';
  String _firstName = '';
  String _lastName = '';

  bool isCredentialsValid(bool isPassword) {
    return isPassword ? _password.isNotEmpty : _email.isNotEmpty;
  }

  bool get isInfoValid {
    return _firstName.isNotEmpty && _lastName.isNotEmpty;
  }

  User? getUserOrNull() => _authState.getUserOrNull();

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

  void _userSubscriber(User? user) {
    _email = user?.email ?? '';
    _firstName = user?.firstName ?? '';
    _lastName = user?.lastName ?? '';
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

  Future<void> _onInit() async {
    try {
      if (_authState.user$.get() == null) {
        _authState.setUser(await _userRepository.getById(_authState.getUserId()));
      }
    } catch (e) {
      onException(e);
    }
  }

  Future<void> updatePictureHandler() async {
    try {
      final File? file = await _fileService.pickImage();

      if (file != null) {
        _authState.setUser(await _userRepository.updatePicture(_authState.getUserId(), file));
      }
    } catch (e) {
      onException(e);
    }
  }

  Future<void> deletePictureHandler() async {
    try {
      _authState.setUser(await _userRepository.deletePicture(_authState.getUserId()));
    } catch (e) {
      onException(e);
    }
  }

  void logout() {
    _authState.reset().then((_) => context.go(RouteEnum.login.value));
  }

  @override
  void dispose() {
    _authState.user$.unsubscribe(_userSubscriber);

    super.dispose();
  }

  @override
  UserViewModel copy(BuildContext context) {
    final copied = UserViewModel(context, _authState, _userRepository, _fileService);

    copied.setEmail(_email);
    copied.setFirstName(_firstName);
    copied.setLastName(_lastName);

    return copied;
  }
}
