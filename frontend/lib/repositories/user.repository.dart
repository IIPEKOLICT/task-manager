import 'package:frontend/models/user.dart';
import 'package:injectable/injectable.dart';

import 'base/base.repository.dart';

@LazySingleton()
class UserRepository extends BaseRepository {
  UserRepository(super.httpClient, super.authState);

  @override
  String get endpoint => 'users';

  Future<List<User>> getAll() async {
    return (await get<List>()).map((json) => User.fromJson(json)).toList();
  }

  // Future<Project> create(String name, List<String> members) async {
  //   return Project.fromJson(await post<Map<String, dynamic>>(body: {'name': name, 'members': members}));
  // }
  //
  // Future<Project> updateName(String id, String name) async {
  //   return Project.fromJson(await patch<Map<String, dynamic>>(path: '$id/name', body: {'name': name}));
  // }
  //
  // Future<Project> updateMembers(String id, List<String> members) async {
  //   return Project.fromJson(await patch<Map<String, dynamic>>(path: '$id/members', body: {'members': members}));
  // }
  //
  // Future<String> deleteById(String id) async {
  //   return DeleteDto.fromJson(await delete<Map<String, dynamic>>(path: id)).id;
  // }
}
