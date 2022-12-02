import 'package:frontend/dtos/request/delete.dto.dart';
import 'package:frontend/models/project.dart';
import 'package:injectable/injectable.dart';

import 'base/base.repository.dart';

@LazySingleton()
class ProjectRepository extends BaseRepository {
  ProjectRepository(super.httpClient, super.authState);

  @override
  String get endpoint => 'projects';

  Future<List<Project>> getByUser() async {
    return (await get<List>()).map((json) => Project.fromJson(json)).toList();
  }

  Future<Project> create(String name, List<String> members) async {
    return Project.fromJson(await post<Map<String, dynamic>>(body: {'name': name, 'members': members}));
  }

  Future<Project> updateById(String id, String name, List<String> members) async {
    return Project.fromJson(await put<Map<String, dynamic>>(path: id, body: {'name': name, 'members': members}));
  }

  Future<String> deleteById(String id) async {
    return DeleteDto.fromJson(await delete<Map<String, dynamic>>(path: id)).id;
  }
}
