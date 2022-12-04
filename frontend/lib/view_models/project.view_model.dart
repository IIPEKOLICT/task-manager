import 'package:frontend/repositories/project.repository.dart';
import 'package:frontend/view_models/base/base.view_model.dart';
import 'package:frontend/view_models/state/project.state.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../enums/route.enum.dart';
import '../models/project.dart';

@Injectable()
class ProjectViewModel extends BaseViewModel {
  final ProjectState _projectState;
  final ProjectRepository _projectRepository;
  bool _isLoading = true;

  ProjectViewModel(@factoryParam super.context, this._projectRepository, this._projectState) {
    _projectState.entities$.subscribe(_projectsSubscriber);
    _loadUserProjects();
  }

  void _projectsSubscriber(List<Project> projects) {
    if (_isLoading) _isLoading = false;
    notifyListeners();
  }

  void Function() pickProjectHandler(Project project) {
    return () {
      _projectState.setCurrentId(project.id);
      context.go('${RouteEnum.projects.value}/${project.id}?canEdit=${project.canEdit}');
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

    super.dispose();
  }
}
