import 'package:flutter/material.dart';
import 'package:frontend/models/comment.dart';
import 'package:frontend/repositories/comment.repository.dart';
import 'package:frontend/state/comment.state.dart';
import 'package:frontend/state/task.state.dart';
import 'package:frontend/view_models/base/loadable.view_model.dart';
import 'package:frontend/view_models/base/page.view_model.dart';
import 'package:injectable/injectable.dart';

import '../repositories/task.repository.dart';

@Injectable()
class CommentViewModel extends PageViewModel<CommentViewModel> with LoadableViewModel {
  final CommentState _commentState;
  final TaskState _taskState;
  final TaskRepository _taskRepository;
  final CommentRepository _commentRepository;

  CommentViewModel(
    @factoryParam super.context,
    this._commentState,
    this._taskState,
    this._taskRepository,
    this._commentRepository,
  );

  @override
  CommentViewModel copy(BuildContext context) {
    return CommentViewModel(
      context,
      _commentState,
      _taskState,
      _taskRepository,
      _commentRepository,
    );
  }

  @override
  CommentViewModel create() {
    _loadComments();
    return this;
  }

  @override
  void onInit() {
    _commentState.entities$.subscribe(loaderSubscriber);
    _commentState.current$.subscribe(_currentCommentSubscriber, lazy: false);
  }

  String _text = '';

  bool get isValid {
    return _text.isNotEmpty;
  }

  bool get isEdit {
    return _commentState.getCurrentOrNull() != null;
  }

  String getText() => _text;
  List<Comment> getComments() => _commentState.getEntities();

  void setText(String value) {
    _text = value;
    notifyListeners();
  }

  void setComment(Comment? value) {
    _commentState.setCurrent(value);
  }

  void _currentCommentSubscriber(Comment? comment) {
    _text = comment?.text ?? '';
  }

  Future<void> _loadComments() async {
    try {
      _commentState.setEntities(await _taskRepository.getTaskComments(_taskState.getCurrentId()));
    } catch (e) {
      onException(e);
    }
  }

  Future<void> _create() async {
    _commentState.addEntity(
      await _taskRepository.createTaskComment(_taskState.getCurrentId(), _text),
    );
  }

  Future<void> _update() async {
    _commentState.updateEntity(
      await _commentRepository.updateById(_commentState.getCurrent().id, _text),
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
      _commentState.setCurrent(null);
      Navigator.of(context).pop();
    }
  }

  Future<void> Function() deleteById(String id) {
    return () async {
      try {
        _commentState.removeEntityById(await _commentRepository.deleteById(id));
      } catch (e) {
        onException(e);
      }
    };
  }

  @override
  void dispose() {
    _commentState.entities$.unsubscribe(loaderSubscriber);
    _commentState.current$.unsubscribe(_currentCommentSubscriber);

    super.dispose();
  }
}
