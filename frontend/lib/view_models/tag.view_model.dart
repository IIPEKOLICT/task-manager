import 'package:frontend/models/project.dart';
import 'package:frontend/models/tag.dart';
import 'package:frontend/repositories/project.repository.dart';
import 'package:frontend/repositories/tag.repository.dart';
import 'package:frontend/view_models/base/base.view_model.dart';
import 'package:frontend/view_models/state/project.state.dart';
import 'package:frontend/view_models/state/tag.state.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class TagViewModel extends BaseViewModel {
  final String _projectId;
  final TagState _tagState;
  final ProjectState _projectState;
  final ProjectRepository _projectRepository;
  final TagRepository _tagRepository;

  TagViewModel(
    @factoryParam super.context,
    @factoryParam this._projectId,
    this._tagState,
    this._projectState,
    this._projectRepository,
    this._tagRepository,
  ) {
    _tagState.entities$.subscribe(_tagsSubscriber);
    _projectState.current$.subscribe(_currentProjectSubscriber);
    _loadProject();
    _loadTags();
  }

  bool _isLoading = true;

  void _tagsSubscriber(List<Tag> tags) {
    if (_isLoading) _isLoading = false;
    notifyListeners();
  }

  void _currentProjectSubscriber(Project? project) => notifyListeners();

  List<Tag> getTags() => _tagState.getEntities();

  bool get isLoading {
    return _isLoading;
  }

  bool get isProjectLoaded {
    return _projectState.getCurrentOrNull() != null;
  }

  Future<void> _loadProject() async {
    try {
      if (_projectState.getCurrentOrNull() == null) {
        _projectState.setCurrent(await _projectRepository.getById(_projectId));
      }
    } catch (e) {
      onException(e);
    }
  }

  Future<void> _loadTags() async {
    try {
      _tagState.setEntities(await _projectRepository.getProjectTags(_projectId));
    } catch (e) {
      onException(e);
    }
  }

  Future<void> Function() deleteById(String id) {
    return () async {
      try {
        _tagState.removeEntityById(await _tagRepository.deleteById(id));
      } catch (e) {
        onException(e);
      }
    };
  }

  @override
  void dispose() {
    _tagState.entities$.unsubscribe(_tagsSubscriber);
    _projectState.current$.subscribe(_currentProjectSubscriber);

    super.dispose();
  }
}
