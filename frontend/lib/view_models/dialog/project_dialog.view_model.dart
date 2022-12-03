import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/repositories/project.repository.dart';
import 'package:frontend/repositories/user.repository.dart';
import 'package:frontend/view_models/base/base.view_model.dart';
import 'package:frontend/view_models/state/auth.state.dart';
import 'package:frontend/view_models/state/project.state.dart';
import 'package:injectable/injectable.dart';

import '../../models/project.dart';

@Injectable()
class ProjectDialogViewModel extends BaseViewModel {
  final ProjectState _projectState;
  final AuthState _authState;
  final ProjectRepository _projectRepository;
  final UserRepository _userRepository;
  final Project? _project;

  ProjectDialogViewModel(@factoryParam super.context, @factoryParam this._project, this._projectRepository,
      this._userRepository, this._projectState, this._authState) {
    _loadAllUsers();
    _members = _project?.members ?? [];
    _name = _project?.name ?? '';
  }

  String _name = '';
  List<String> _members = [];
  List<User> _users = [];

  String getName() => _name;
  List<String> getMembers() => _members;
  List<User> getUsers() => _users;

  bool get isValid {
    return _name.isNotEmpty;
  }

  bool isUserAdded(String userId) {
    return _members.any((element) => element == userId);
  }

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  void Function(bool?) changeMemberHandler(String userId) {
    return (bool? checked) {
      if (checked == true) {
        _members.add(userId);
      } else {
        _members.remove(userId);
      }

      notifyListeners();
    };
  }

  Future<void> _loadAllUsers() async {
    _users = (await _userRepository.getAll()).where((User user) => user.id != _authState.getUserIdOrNull()).toList();
    notifyListeners();
  }

  Future<void> _createHandler() async {
    try {
      _projectState.addEntity(await _projectRepository.create(_name, _members));
    } catch (e) {
      onException(e);
    }
  }

  Future<void> _updateHandler() async {
    try {
      if (_project?.id == null) throw Exception();

      _projectState.updateEntity(
        await _projectRepository.updateById(_project!.id, _name, _members),
      );
    } catch (e) {
      onException(e);
    }
  }

  Future<void> Function() submitHandler(bool isEdit) {
    return () async {
      try {
        if (isEdit) {
          await _updateHandler();
        } else {
          await _createHandler();
        }
      } catch (e) {
        onException(e);
      } finally {
        Navigator.of(context).pop();
      }
    };
  }
}
