import 'package:flutter/material.dart';
import 'package:frontend/models/tag.dart';
import 'package:frontend/repositories/project.repository.dart';
import 'package:frontend/repositories/tag.repository.dart';
import 'package:frontend/view_models/base/page.view_model.dart';
import 'package:frontend/view_models/state/project.state.dart';
import 'package:frontend/view_models/state/tag.state.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class TagViewModel extends PageViewModel<TagViewModel> {
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
  );

  @override
  void onInit() {
    _tagState.entities$.subscribe(_tagsSubscriber);
  }

  @override
  TagViewModel create() {
    _loadTags();
    return this;
  }

  bool _isLoading = true;
  String _name = '';

  String getName() => _name;

  bool get isValid {
    return _name.isNotEmpty;
  }

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

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

  void setTag(Tag? tag) {
    _tagState.setCurrent(tag);
  }

  Future<void> _create() async {
    _tagState.addEntity(await _projectRepository.createProjectTag(_projectState.getCurrentId(), _name));
  }

  Future<void> _update() async {
    _tagState.updateEntity(await _tagRepository.updateName(_tagState.getCurrent().id, _name));
    _tagState.setCurrent(null);
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

  @override
  TagViewModel copy(BuildContext context) {
    final copied = TagViewModel(
      context,
      _tagState,
      _projectState,
      _projectRepository,
      _tagRepository,
    );

    copied.setName(_name);
    return copied;
  }
}
