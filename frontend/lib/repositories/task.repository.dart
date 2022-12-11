import 'dart:io';

import 'package:dio/dio.dart';
import 'package:frontend/dtos/response/delete.dto.dart';
import 'package:frontend/enums/status.enum.dart';
import 'package:frontend/models/attachment.dart';
import 'package:frontend/models/comment.dart';
import 'package:frontend/models/note.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';

import '../enums/priority.enum.dart';
import '../models/task.dart';
import '../models/work.dart';
import 'base/base.repository.dart';

@LazySingleton()
class TaskRepository extends BaseRepository {
  TaskRepository(super.httpClient, super.mainInterceptor);

  @override
  String get endpoint => 'tasks';

  Future<Task> getById(String id) async {
    return Task.fromJson(await get<Map<String, dynamic>>(path: id));
  }

  Future<List<Note>> getTaskNotes(String id) async {
    return (await get<List>(path: '$id/notes')).map((json) => Note.fromJson(json)).toList();
  }

  Future<List<Comment>> getTaskComments(String id) async {
    return (await get<List>(path: '$id/comments')).map((json) => Comment.fromJson(json)).toList();
  }

  Future<List<Attachment>> getTaskAttachments(String id) async {
    return (await get<List>(path: '$id/attachments')).map((json) => Attachment.fromJson(json)).toList();
  }

  Future<List<Work>> getTaskWorks(String id) async {
    return (await get<List>(path: '$id/works')).map((json) => Work.fromJson(json)).toList();
  }

  Future<Note> createTaskNote(String id, String header, String text) async {
    return Note.fromJson(
      await post<Map<String, dynamic>>(
        path: '$id/notes',
        body: {
          'header': header,
          'text': text,
        },
      ),
    );
  }

  Future<Comment> createTaskComment(String id, String text) async {
    return Comment.fromJson(
      await post<Map<String, dynamic>>(
        path: '$id/comments',
        body: {'text': text},
      ),
    );
  }

  Future<Attachment> createTaskAttachment(String id, File file) async {
    final List<String> parsedMimeData = lookupMimeType(file.path)?.split('/') ?? ['text', 'plain'];

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
        contentType: MediaType(parsedMimeData[0], parsedMimeData[1]),
      )
    });

    return Attachment.fromJson(
      await post<Map<String, dynamic>>(path: '$id/attachments', body: formData),
    );
  }

  Future<Work> createTaskWork(
    String id,
    String description,
    DateTime startDate,
    DateTime endDate,
  ) async {
    return Work.fromJson(
      await post<Map<String, dynamic>>(
        path: '$id/works',
        body: {
          'description': description,
          'startDate': startDate.toUtc().toString(),
          'endDate': endDate.toUtc().toString(),
        },
      ),
    );
  }

  Future<Task> updateInfo(String id, String title, String description, num? expectedHours) async {
    return Task.fromJson(await patch<Map<String, dynamic>>(
      path: '$id/info',
      body: {'title': title, 'description': description, 'expectedHours': expectedHours},
    ));
  }

  Future<Task> updateAssignedTo(String id, String userId) async {
    return Task.fromJson(
      await patch<Map<String, dynamic>>(
        path: '$id/assigned-to',
        body: {'assignedTo': userId},
      ),
    );
  }

  Future<Task> updateStatus(String id, StatusEnum status) async {
    return Task.fromJson(
      await patch<Map<String, dynamic>>(
        path: '$id/status',
        body: {'status': status.value},
      ),
    );
  }

  Future<Task> updatePriority(String id, PriorityEnum priority) async {
    return Task.fromJson(
      await patch<Map<String, dynamic>>(
        path: '$id/priority',
        body: {'priority': priority.value},
      ),
    );
  }

  Future<Task> updateTags(String id, List<String> tags) async {
    return Task.fromJson(
      await patch<Map<String, dynamic>>(
        path: '$id/tags',
        body: {'tags': tags},
      ),
    );
  }

  Future<Task> updateBlockedBy(String id, List<String> blockedBy) async {
    return Task.fromJson(
      await patch<Map<String, dynamic>>(
        path: '$id/blocked-by',
        body: {'blockedBy': blockedBy},
      ),
    );
  }

  Future<String> deleteById(String id) async {
    return DeleteDto.fromJson(await delete<Map<String, dynamic>>(path: id)).id;
  }
}
