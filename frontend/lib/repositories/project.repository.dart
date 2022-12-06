import 'package:frontend/dtos/response/delete.dto.dart';
import 'package:frontend/models/project.dart';
import 'package:frontend/models/tag.dart';
import 'package:frontend/models/user.dart';
import 'package:injectable/injectable.dart';

import '../dtos/request/create_task.dto.dart';
import '../models/task.dart';
import 'base/base.repository.dart';

@LazySingleton()
class ProjectRepository extends BaseRepository {
  ProjectRepository(super.httpClient, super.mainInterceptor);

  @override
  String get endpoint => 'projects';

  Future<List<Project>> getByUser() async {
    return (await get<List>()).map((json) => Project.fromJson(json)).toList();
  }

  Future<Project> getById(String id) async {
    return Project.fromJson(await get<Map<String, dynamic>>(path: id));
  }

  Future<List<Tag>> getProjectTags(String id) async {
    return (await get<List>(path: '$id/tags')).map((json) => Tag.fromJson(json)).toList();
  }

  Future<List<Task>> getProjectTasks(String id) async {
    return (await get<List>(path: '$id/tasks')).map((json) => Task.fromJson(json)).toList();
  }

  Future<List<User>> getProjectUsers(String id) async {
    return (await get<List>(path: '$id/users')).map((json) => User.fromJson(json)).toList();
  }

  Future<Project> create(String name, List<String> members) async {
    return Project.fromJson(await post<Map<String, dynamic>>(body: {'name': name, 'members': members}));
  }

  Future<Tag> createProjectTag(String projectId, String name) async {
    return Tag.fromJson(await post<Map<String, dynamic>>(path: '$projectId/tags', body: {'name': name}));
  }

  Future<Task> createProjectTask(String projectId, CreateTaskDto dto) async {
    return Task.fromJson(await post<Map<String, dynamic>>(path: '$projectId/tasks', body: dto.json));
  }

  Future<Project> updateById(String id, String name, List<String> members) async {
    return Project.fromJson(await put<Map<String, dynamic>>(path: id, body: {'name': name, 'members': members}));
  }

  Future<String> deleteById(String id) async {
    return DeleteDto.fromJson(await delete<Map<String, dynamic>>(path: id)).id;
  }
}
