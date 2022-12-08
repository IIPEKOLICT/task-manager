import 'package:flutter/material.dart';
import 'package:frontend/repositories/project.repository.dart';
import 'package:frontend/view_models/base/page.view_model.dart';
import 'package:frontend/view_models/state/auth.state.dart';
import 'package:frontend/view_models/state/project.state.dart';
import 'package:frontend/view_models/state/tag.state.dart';
import 'package:frontend/view_models/state/user.state.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../enums/route.enum.dart';
import '../models/project.dart';
import '../models/user.dart';
import '../repositories/user.repository.dart';

@Injectable()
class ProjectViewModel extends PageViewModel<ProjectViewModel> {
  final AuthState _authState;
  final UserState _userState;
  final TagState _tagState;
  final ProjectState _projectState;
  final ProjectRepository _projectRepository;
  final UserRepository _userRepository;

  ProjectViewModel(
    @factoryParam super.context,
    this._projectRepository,
    this._userRepository,
    this._projectState,
    this._userState,
    this._tagState,
    this._authState,
  );

  @override
  void onInit() {
    _projectState.entities$.subscribe(_projectsSubscriber);
    _userState.entities$.subscribe(defaultSubscriber, lazy: false);
  }

  @override
  ProjectViewModel create() {
    _loadUserProjects();

    if (_userState.getEntities().isEmpty) {
      _loadAllUsers();
    }

    return this;
  }

  bool _isLoading = true;
  String _name = '';
  List<String> _members = [];

  String getName() => _name;
  List<String> getMembers() => _members;
  List<User> getUsers() => _userState.getEntities();

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

  void setMembers(List<String> value) {
    _members = value;
    notifyListeners();
  }

  void setProject(Project? value) {
    _projectState.setCurrent(value);
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
    try {
      _userState.setEntities(
        (await _userRepository.getAll())
            .where(
              (User user) => user.id != _authState.getUserIdOrNull(),
            )
            .toList(),
      );
    } catch (e) {
      onException(e);
    }
  }

  Future<void> _create() async {
    _projectState.addEntity(await _projectRepository.create(_name, _members));
  }

  Future<void> _update() async {
    _projectState.updateEntity(
      await _projectRepository.updateById(_projectState.getCurrentId(), _name, _members),
    );
  }

  Future<void> Function() submitHandler(bool isEdit) {
    return () async {
      try {
        if (isEdit) {
          await _update();
        } else {
          await _create();
        }
      } catch (e) {
        onException(e);
      } finally {
        Navigator.of(context).pop();
      }
    };
  }

  void _projectsSubscriber(List<Project> projects) {
    if (_isLoading) _isLoading = false;
    notifyListeners();
  }

  void Function() pickProjectHandler(Project project) {
    return () {
      _projectState.setCurrentId(project.id);
      _projectState.setCurrent(project);
      _userState.setEntities([]);
      _tagState.setEntities([]);
      context.go('${RouteEnum.project.value}?canEdit=${project.canEdit}');
    };
  }

  List<Project> getProjects() => _projectState.getEntities();

  bool get isLoading {
    return _isLoading;
  }

  Future<void> _loadUserProjects() async {
    try {
      _projectState.setEntities(await _projectRepository.getByUser());
    } catch (e) {
      onException(e);
    }
  }

  Future<void> Function() deleteById(String id) {
    return () async {
      try {
        _projectState.removeEntityById(await _projectRepository.deleteById(id));
      } catch (e) {
        onException(e);
      }
    };
  }

  @override
  void dispose() {
    _projectState.entities$.unsubscribe(_projectsSubscriber);
    _userState.entities$.unsubscribe(defaultSubscriber);

    super.dispose();
  }

  @override
  ProjectViewModel copy(BuildContext context) {
    final copied = ProjectViewModel(
      context,
      _projectRepository,
      _userRepository,
      _projectState,
      _userState,
      _tagState,
      _authState,
    );

    copied.setName(_name);
    copied.setMembers(_projectState.getCurrentOrNull()?.members ?? []);

    return copied;
  }
}
