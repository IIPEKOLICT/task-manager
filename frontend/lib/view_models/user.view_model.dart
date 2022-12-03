import 'dart:io';

import 'package:frontend/models/user.dart';
import 'package:frontend/view_models/base/base.view_model.dart';
import 'package:frontend/view_models/state/auth.state.dart';
import 'package:injectable/injectable.dart';

import '../repositories/user.repository.dart';
import '../services/file.service.dart';

@Injectable()
class UserViewModel extends BaseViewModel {
  final AuthState _authState;
  final UserRepository _userRepository;
  final FileService _fileService;

  UserViewModel(@factoryParam super.context, this._authState, this._userRepository, this._fileService) {
    _authState.user$.subscribe(_userSubscriber);
    _onInit();
  }

  User? getUserOrNull() => _authState.getUserOrNull();

  void _userSubscriber(User? user) => notifyListeners();

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

  @override
  void dispose() {
    _authState.user$.unsubscribe(_userSubscriber);

    super.dispose();
  }
}
