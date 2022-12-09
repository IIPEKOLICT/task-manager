import 'package:frontend/dtos/response/delete.dto.dart';
import 'package:frontend/models/attachment.dart';
import 'package:injectable/injectable.dart';

import 'base/base.repository.dart';

@LazySingleton()
class AttachmentRepository extends BaseRepository {
  AttachmentRepository(super.httpClient, super.mainInterceptor);

  @override
  String get endpoint => 'attachments';

  Future<Attachment> getById(String id) async {
    return Attachment.fromJson(await get<Map<String, dynamic>>(path: id));
  }

  Future<String> deleteById(String id) async {
    return DeleteDto.fromJson(await delete<Map<String, dynamic>>(path: id)).id;
  }
}
