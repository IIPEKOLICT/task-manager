import 'package:flutter/material.dart';
import 'package:frontend/models/note.dart';
import 'package:frontend/view_models/base/loadable.view_model.dart';
import 'package:frontend/view_models/base/page.view_model.dart';
import 'package:frontend/view_models/state/note.state.dart';
import 'package:frontend/view_models/state/task.state.dart';
import 'package:injectable/injectable.dart';

import '../repositories/note.repository.dart';
import '../repositories/task.repository.dart';

@Injectable()
class NoteViewModel extends PageViewModel<NoteViewModel> with LoadableViewModel {
  final NoteState _noteState;
  final TaskState _taskState;
  final TaskRepository _taskRepository;
  final NoteRepository _noteRepository;

  NoteViewModel(
    @factoryParam super.context,
    this._noteState,
    this._taskState,
    this._taskRepository,
    this._noteRepository,
  );

  @override
  NoteViewModel copy(BuildContext context) {
    final copied = NoteViewModel(context, _noteState, _taskState, _taskRepository, _noteRepository);

    copied.setText(_text);
    copied.setHeader(_header);

    return copied;
  }

  @override
  NoteViewModel create() {
    _loadNotes();
    return this;
  }

  @override
  void onInit() {
    _noteState.entities$.subscribe(loaderSubscriber);
  }

  String _header = '';
  String _text = '';

  bool get isValid {
    return _header.isNotEmpty && _text.isNotEmpty;
  }

  Note getNote() => _noteState.getCurrent();
  List<Note> getNotes() => _noteState.getEntities();

  void setHeader(String value) {
    _header = value;
    notifyListeners();
  }

  void setText(String value) {
    _text = value;
    notifyListeners();
  }

  void setNote(Note? value) {
    _noteState.setCurrent(value);
  }

  Future<void> _loadNotes() async {
    try {
      _noteState.setEntities(await _taskRepository.getTaskNotes(_taskState.getCurrentId()));
    } catch (e) {
      onException(e);
    }
  }

  Future<void> _create() async {
    _noteState.addEntity(
      await _taskRepository.createTaskNote(_taskState.getCurrentId(), _header, _text),
    );
  }

  Future<void> _update() async {
    _noteState.updateEntity(
      await _noteRepository.updateById(_noteState.getCurrent().id, _header, _text),
    );

    _noteState.setCurrent(null);
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
        _noteState.removeEntityById(await _noteRepository.deleteById(id));
      } catch (e) {
        onException(e);
      }
    };
  }

  @override
  void dispose() {
    _noteState.entities$.unsubscribe(loaderSubscriber);

    super.dispose();
  }
}
