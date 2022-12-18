import 'package:frontend/dtos/response/gantt_chart.dto.dart';
import 'package:frontend/models/project.dart';
import 'package:frontend/models/tag.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/repositories/base/read_delete.repository.dart';
import 'package:injectable/injectable.dart';

import '../dtos/request/create_task.dto.dart';
import '../models/task.dart';
import 'base/base.repository.dart';

@LazySingleton()
class ProjectRepository extends BaseRepository with ReadDeleteRepository<Project> {
  ProjectRepository(super.httpClient, super.mainInterceptor);

  @override
  String get endpoint => 'projects';

  @override
  Project Function(Map<String, dynamic> p1) get convertResponse => Project.fromJson;

  Future<List<Project>> getByUser() async {
    return (await get<List>()).map((json) => convertResponse(json)).toList();
  }

  Future<List<Tag>> getProjectTags(String id) async {
    return (await get<List>(path: '$id/tags')).map((json) => Tag.fromJson(json)).toList();
  }

  Future<List<Task>> getProjectTasks(String id) async {
    return (await get<List>(path: '$id/tasks')).map((json) => Task.fromJson(json)).toList();
  }

  Future<GanttChartDto> getProjectGanttChart(String id) async {
    return GanttChartDto.fromJSON(await get<Map<String, dynamic>>(path: '$id/gantt-chart'));
  }

  Future<List<User>> getProjectUsers(String id) async {
    return (await get<List>(path: '$id/users')).map((json) => User.fromJson(json)).toList();
  }

  Future<Project> create(String name, List<String> members) async {
    return convertResponse(await post<Map<String, dynamic>>(body: {'name': name, 'members': members}));
  }

  Future<Tag> createProjectTag(String projectId, String name) async {
    return Tag.fromJson(await post<Map<String, dynamic>>(path: '$projectId/tags', body: {'name': name}));
  }

  Future<Task> createProjectTask(String projectId, CreateTaskDto dto) async {
    return Task.fromJson(await post<Map<String, dynamic>>(path: '$projectId/tasks', body: dto.json));
  }

  Future<Project> updateById(String id, String name, List<String> members) async {
    return convertResponse(await put<Map<String, dynamic>>(path: id, body: {'name': name, 'members': members}));
  }
}
