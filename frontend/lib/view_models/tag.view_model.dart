import 'package:flutter/material.dart';
import 'package:frontend/models/tag.dart';
import 'package:frontend/repositories/project.repository.dart';
import 'package:frontend/repositories/tag.repository.dart';
import 'package:frontend/view_models/base/loadable.view_model.dart';
import 'package:frontend/view_models/base/page.view_model.dart';
import 'package:frontend/view_models/state/project.state.dart';
import 'package:frontend/view_models/state/tag.state.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class TagViewModel extends PageViewModel<TagViewModel> with LoadableViewModel {
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
    _tagState.entities$.subscribe(loaderSubscriber);
    _tagState.current$.subscribe(_currentTagSubscriber, lazy: false);
  }

  @override
  TagViewModel create() {
    _loadTags();
    return this;
  }

  String _name = '';

  String getName() => _name;

  bool get isValid {
    return _name.isNotEmpty;
  }

  bool get isEdit {
    return _tagState.getCurrentOrNull() != null;
  }

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  void _currentTagSubscriber(Tag? tag) {
    _name = tag?.name ?? '';
  }

  List<Tag> getTags() => _tagState.getEntities();

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
  }

  Future<void> submitHandler() async {
    try {
      if (isEdit) {
        await _update();
      } else {
        await _create();
      }
    } catch (e) {
      onException(e);
    } finally {
      _tagState.setCurrent(null);
      Navigator.of(context).pop();
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
    _tagState.entities$.unsubscribe(loaderSubscriber);
    _tagState.current$.unsubscribe(_currentTagSubscriber);

    super.dispose();
  }

  @override
  TagViewModel copy(BuildContext context) {
    return TagViewModel(
      context,
      _tagState,
      _projectState,
      _projectRepository,
      _tagRepository,
    );
  }
}
