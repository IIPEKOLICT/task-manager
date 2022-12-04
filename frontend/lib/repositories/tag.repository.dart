import 'package:frontend/dtos/response/delete.dto.dart';
import 'package:frontend/models/tag.dart';
import 'package:injectable/injectable.dart';

import 'base/base.repository.dart';

@LazySingleton()
class TagRepository extends BaseRepository {
  TagRepository(super.httpClient, super.authState);

  @override
  String get endpoint => 'tags';

  Future<Tag> getById(String id) async {
    return Tag.fromJson(await get<Map<String, dynamic>>(path: id));
  }

  Future<Tag> updateName(String id, String name) async {
    return Tag.fromJson(await patch<Map<String, dynamic>>(path: '$id/name', body: {'name': name}));
  }

  Future<String> deleteById(String id) async {
    return DeleteDto.fromJson(await delete<Map<String, dynamic>>(path: id)).id;
  }
}
