import 'package:flutter/material.dart';
import 'package:frontend/dtos/request/create_task.dto.dart';
import 'package:frontend/enums/priority.enum.dart';
import 'package:frontend/enums/status.enum.dart';
import 'package:frontend/models/tag.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/repositories/project.repository.dart';
import 'package:frontend/view_models/base/base.view_model.dart';
import 'package:frontend/view_models/state/project.state.dart';
import 'package:frontend/view_models/state/tag.state.dart';
import 'package:frontend/view_models/state/task.state.dart';
import 'package:frontend/view_models/state/user.state.dart';
import 'package:injectable/injectable.dart';

import '../models/task.dart';

@Injectable()
class TaskViewModel extends BaseViewModel {
  final Task? _task;
  final ProjectState _projectState;
  final TaskState _taskState;
  final TagState _tagState;
  final UserState _userState;
  final ProjectRepository _projectRepository;

  TaskViewModel(
    @factoryParam super.context,
    @factoryParam this._task,
    this._projectRepository,
    this._projectState,
    this._userState,
    this._taskState,
    this._tagState,
  ) {
    _tagState.entities$.subscribe(defaultSubscriber);
    _userState.entities$.subscribe(defaultSubscriber);
    _loadProjectTags();
    _loadProjectUsers();
  }

  User? _assignedTo;
  String _title = '';
  String _description = '';
  PriorityEnum _priority = PriorityEnum.normal;
  StatusEnum _status = StatusEnum.todo;
  num? _expectedHours;
  List<String> _tagsIds = [];
  List<String> _blockedByIds = [];

  PriorityEnum getPriority() => _priority;
  StatusEnum getStatus() => _status;
  User? getAssignedToOrNull() => _assignedTo;
  List<User> getProjectUsers() => _userState.getEntities();
  List<Tag> getProjectTags() => _tagState.getEntities();

  List<Task> getProjectTasks() {
    return _task == null
        ? _taskState.getEntities()
        : _taskState.getEntities().where((element) => element.id != _task!.id).toList();
  }

  Future<void> _loadProjectTags() async {
    _tagState.setEntities(await _projectRepository.getProjectTags(_projectState.getCurrentId()));
  }

  Future<void> _loadProjectUsers() async {
    _userState.setEntities(await _projectRepository.getProjectUsers(_projectState.getCurrentId()));
  }

  bool isTagAdded(String tagId) {
    return _tagsIds.any((element) => element == tagId);
  }

  bool isBlockedByAdded(String blockedById) {
    return _blockedByIds.any((element) => element == blockedById);
  }

  bool get isValidForCreate {
    return _title.isNotEmpty && _assignedTo != null;
  }

  void setTitle(String value) {
    _title = value;
    notifyListeners();
  }

  void setDescription(String value) {
    _description = value;
    notifyListeners();
  }

  void setPriority(PriorityEnum? value) {
    if (value != null) {
      _priority = value;
      notifyListeners();
    }
  }

  void setStatus(StatusEnum? value) {
    if (value != null) {
      _status = value;
      notifyListeners();
    }
  }

  void setAssignedTo(User? value) {
    _assignedTo = value;
    notifyListeners();
  }

  void setExpectedHours(String value) {
    _expectedHours = num.tryParse(value);
    notifyListeners();
  }

  void Function(bool?) _changeIdHandler(List<String> list, String id) {
    return (bool? checked) {
      if (checked == true) {
        list.add(id);
      } else {
        list.remove(id);
      }

      notifyListeners();
    };
  }

  void Function(bool?) changeTagHandler(String tagId) {
    return _changeIdHandler(_tagsIds, tagId);
  }

  void Function(bool?) changeBlockedByHandler(String blockedById) {
    return _changeIdHandler(_blockedByIds, blockedById);
  }

  Future<void> createHandler() async {
    try {
      final dto = CreateTaskDto(
        assignedTo: _assignedTo?.id ?? (throw Exception()),
        title: _title,
        description: _description,
        priority: _priority,
        status: _status,
        tags: _tagsIds,
        blockedBy: _blockedByIds,
        expectedHours: _expectedHours,
      );

      _taskState.addEntity(await _projectRepository.createProjectTask(_projectState.getCurrentId(), dto));
    } catch (e) {
      onException(e);
    } finally {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _tagState.entities$.unsubscribe(defaultSubscriber);
    _userState.entities$.unsubscribe(defaultSubscriber);

    super.dispose();
  }
}
