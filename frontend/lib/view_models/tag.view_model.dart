import 'package:frontend/models/tag.dart';
import 'package:frontend/repositories/project.repository.dart';
import 'package:frontend/repositories/tag.repository.dart';
import 'package:frontend/view_models/base/base.view_model.dart';
import 'package:frontend/view_models/state/project.state.dart';
import 'package:frontend/view_models/state/tag.state.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class TagViewModel extends BaseViewModel {
  final TagState _tagState;
  final ProjectState _projectState;
  final ProjectRepository _projectRepository;
  final TagRepository _tagRepository;

  TagViewModel(
    @factoryParam super.context,
    this._tagState,
    this._projectState,
    this._projectRepository,
    this._tagRepository,
  ) {
    _tagState.entities$.subscribe(_tagsSubscriber);
    _loadTags();
  }

  bool _isLoading = true;

  void _tagsSubscriber(List<Tag> tags) {
    if (_isLoading) _isLoading = false;
    notifyListeners();
  }

  List<Tag> getTags() => _tagState.getEntities();

  bool get isLoading {
    return _isLoading;
  }

  Future<void> _loadTags() async {
    try {
      _tagState.setEntities(await _projectRepository.getProjectTags(_projectState.getCurrentId()));
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

    super.dispose();
  }
}
