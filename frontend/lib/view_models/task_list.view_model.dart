import 'package:frontend/enums/priority.enum.dart';
import 'package:frontend/models/task.dart';
import 'package:frontend/repositories/project.repository.dart';
import 'package:frontend/view_models/base/base.view_model.dart';
import 'package:frontend/view_models/base/loadable.view_model.dart';
import 'package:frontend/view_models/state/project.state.dart';
import 'package:frontend/view_models/state/task.state.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../enums/route.enum.dart';
import '../enums/status.enum.dart';
import '../repositories/task.repository.dart';

@Injectable()
class TaskListViewModel extends BaseViewModel with LoadableViewModel {
  final TaskState _taskState;
  final ProjectState _projectState;
  final ProjectRepository _projectRepository;
  final TaskRepository _taskRepository;

  TaskListViewModel(
    @factoryParam super.context,
    this._taskState,
    this._projectState,
    this._projectRepository,
    this._taskRepository,
  );

  @override
  void onInit() {
    _taskState.entities$.subscribe(loaderSubscriber);
    _loadTasks();
  }

  List<Task> getTasks() => _taskState.getEntities();

  void Function() pickTaskHandler(String taskId) {
    return () {
      _taskState.setCurrentId(taskId);
      context.go('${RouteEnum.task.value}?isOwnerOfProject=${_projectState.getCurrent().canEdit}');
    };
  }

  Future<void> _loadTasks() async {
    try {
      _taskState.setEntities(await _projectRepository.getProjectTasks(_projectState.getCurrentId()));
    } catch (e) {
      onException(e);
    }
  }

  Future<void> Function() _update(Future<Task> Function() taskGetter) {
    return () async {
      try {
        _taskState.updateEntity(await taskGetter());
      } catch (e) {
        onException(e);
      }
    };
  }

  Future<void> Function() updatePriorityHandler(String id, PriorityEnum priority) {
    return _update(() async => _taskRepository.updatePriority(id, priority));
  }

  Future<void> Function() updateStatusHandler(String id, StatusEnum status) {
    return _update(() async => _taskRepository.updateStatus(id, status));
  }

  Future<void> Function() deleteById(String id) {
    return () async {
      try {
        _taskState.removeEntityById(await _taskRepository.deleteById(id));
      } catch (e) {
        onException(e);
      }
    };
  }

  @override
  void dispose() {
    _taskState.entities$.unsubscribe(loaderSubscriber);

    super.dispose();
  }
}
