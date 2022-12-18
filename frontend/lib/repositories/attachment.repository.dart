import 'package:frontend/models/attachment.dart';
import 'package:frontend/repositories/base/read_delete.repository.dart';
import 'package:injectable/injectable.dart';

import 'base/base.repository.dart';

@LazySingleton()
class AttachmentRepository extends BaseRepository with ReadDeleteRepository<Attachment> {
  AttachmentRepository(super.httpClient, super.mainInterceptor);

  @override
  String get endpoint => 'attachments';

  @override
  Attachment Function(Map<String, dynamic> p1) get convertResponse => Attachment.fromJson;
}
