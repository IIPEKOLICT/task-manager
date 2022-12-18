import 'package:frontend/models/tag.dart';
import 'package:frontend/repositories/base/read_delete.repository.dart';
import 'package:injectable/injectable.dart';

import 'base/base.repository.dart';

@LazySingleton()
class TagRepository extends BaseRepository with ReadDeleteRepository<Tag> {
  TagRepository(super.httpClient, super.mainInterceptor);

  @override
  String get endpoint => 'tags';

  @override
  Tag Function(Map<String, dynamic> p1) get convertResponse => Tag.fromJson;

  Future<Tag> updateName(String id, String name) async {
    return convertResponse(await patch<Map<String, dynamic>>(path: '$id/name', body: {'name': name}));
  }
}
