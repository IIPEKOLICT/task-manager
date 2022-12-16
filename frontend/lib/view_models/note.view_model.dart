import 'package:flutter/material.dart';
import 'package:frontend/models/note.dart';
import 'package:frontend/state/note.state.dart';
import 'package:frontend/state/task.state.dart';
import 'package:frontend/view_models/base/loadable.view_model.dart';
import 'package:frontend/view_models/base/page.view_model.dart';
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
    return NoteViewModel(context, _noteState, _taskState, _taskRepository, _noteRepository);
  }

  @override
  NoteViewModel create() {
    _loadNotes();
    return this;
  }

  @override
  void onInit() {
    _noteState.entities$.subscribe(loaderSubscriber);
    _noteState.current$.subscribe(_currentNoteSubscriber, lazy: false);
  }

  String _header = '';
  String _text = '';

  bool get isValid {
    return _header.isNotEmpty && _text.isNotEmpty;
  }

  bool get isEdit {
    return _noteState.getCurrentOrNull() != null;
  }

  String getHeader() => _header;
  String getText() => _text;
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

  void _currentNoteSubscriber(Note? note) {
    _header = note?.header ?? '';
    _text = note?.text ?? '';
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
      _noteState.setCurrent(null);
      Navigator.of(context).pop();
    }
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
    _noteState.current$.unsubscribe(_currentNoteSubscriber);

    super.dispose();
  }
}
