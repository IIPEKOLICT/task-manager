import 'package:frontend/dtos/response/delete.dto.dart';
import 'package:frontend/enums/status.enum.dart';
import 'package:injectable/injectable.dart';

import '../enums/priority.enum.dart';
import '../models/task.dart';
import 'base/base.repository.dart';

@LazySingleton()
class TaskRepository extends BaseRepository {
  TaskRepository(super.httpClient, super.mainInterceptor);

  @override
  String get endpoint => 'tasks';

  Future<Task> getById(String id) async {
    return Task.fromJson(await get<Map<String, dynamic>>(path: id));
  }

  Future<List<Task>> getAllowedBlockedBy(String id) async {
    return (await get<List>(path: '$id/blocked-by')).map((json) => Task.fromJson(json)).toList();
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
