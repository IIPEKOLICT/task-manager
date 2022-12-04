import 'package:flutter/material.dart';
import 'package:frontend/repositories/project.repository.dart';
import 'package:frontend/repositories/tag.repository.dart';
import 'package:frontend/view_models/base/base.view_model.dart';
import 'package:frontend/view_models/state/project.state.dart';
import 'package:frontend/view_models/state/tag.state.dart';
import 'package:injectable/injectable.dart';

import '../../models/tag.dart';

@Injectable()
class TagDialogViewModel extends BaseViewModel {
  final Tag? _tag;
  final TagState _tagState;
  final ProjectState _projectState;
  final TagRepository _tagRepository;
  final ProjectRepository _projectRepository;

  TagDialogViewModel(
    @factoryParam super.context,
    @factoryParam this._tag,
    this._projectState,
    this._tagRepository,
    this._projectRepository,
    this._tagState,
  ) {
    _name = _tag?.name ?? '';
  }

  String _name = '';

  String getName() => _name;

  bool get isValid {
    return _name.isNotEmpty;
  }

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  Future<void> _createHandler() async {
    try {
      _tagState.addEntity(await _projectRepository.createProjectTag(_projectState.getCurrentId(), _name));
    } catch (e) {
      onException(e);
    }
  }

  Future<void> _updateHandler() async {
    try {
      if (_tag?.id == null) throw Exception();
      _tagState.updateEntity(await _tagRepository.updateName(_tag!.id, _name));
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
