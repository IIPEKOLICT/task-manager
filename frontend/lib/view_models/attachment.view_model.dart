import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/models/attachment.dart';
import 'package:frontend/state/attachment.state.dart';
import 'package:frontend/state/task.state.dart';
import 'package:frontend/view_models/base/loadable.view_model.dart';
import 'package:frontend/view_models/base/page.view_model.dart';
import 'package:injectable/injectable.dart';

import '../repositories/attachment.repository.dart';
import '../repositories/task.repository.dart';
import '../services/file.service.dart';

@Injectable()
class AttachmentViewModel extends PageViewModel<AttachmentViewModel> with LoadableViewModel {
  final AttachmentState _attachmentState;
  final TaskState _taskState;
  final TaskRepository _taskRepository;
  final AttachmentRepository _attachmentRepository;
  final FileService _fileService;

  AttachmentViewModel(
    @factoryParam super.context,
    this._attachmentState,
    this._taskState,
    this._taskRepository,
    this._attachmentRepository,
    this._fileService,
  );

  @override
  AttachmentViewModel copy(BuildContext context) {
    return this;
  }

  @override
  AttachmentViewModel create() {
    _loadAttachments();
    return this;
  }

  @override
  void onInit() {
    _attachmentState.entities$.subscribe(loaderSubscriber);
  }

  List<Attachment> getAttachments() => _attachmentState.getEntities();

  Future<void> _loadAttachments() async {
    try {
      _attachmentState.setEntities(
        await _taskRepository.getTaskAttachments(_taskState.getCurrentId()),
      );
    } catch (e) {
      onException(e);
    }
  }

  Future<void> createHandler() async {
    try {
      final File? file = await _fileService.pickFile();

      if (file == null) return;

      _attachmentState.addEntity(
        await _taskRepository.createTaskAttachment(_taskState.getCurrentId(), file),
      );
    } catch (e) {
      onException(e);
    }
  }

  Future<void> Function()? copyUrlHandler(String? url) {
    return url != null
        ? () async {
            try {
              await Clipboard.setData(ClipboardData(text: url));
              onSuccess('Ссылка на вложение скопирована');
            } catch (e) {
              onException(e);
            }
          }
        : null;
  }

  Future<void> Function()? downloadHandler(Attachment attachment) {
    return attachment.url != null
        ? () async {
            try {
              if (await _fileService.saveFile(attachment.name, attachment.url!)) {
                onSuccess('Файл успешно загружен');
              }
            } catch (e) {
              onException(e);
            }
          }
        : null;
  }

  Future<void> Function() deleteById(String id) {
    return () async {
      try {
        _attachmentState.removeEntityById(await _attachmentRepository.deleteById(id));
      } catch (e) {
        onException(e);
      }
    };
  }

  @override
  void dispose() {
    _attachmentState.entities$.unsubscribe(loaderSubscriber);

    super.dispose();
  }
}
