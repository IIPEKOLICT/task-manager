import 'package:frontend/models/comment.dart';
import 'package:frontend/repositories/base/read_delete.repository.dart';
import 'package:injectable/injectable.dart';

import 'base/base.repository.dart';

@LazySingleton()
class CommentRepository extends BaseRepository with ReadDeleteRepository<Comment> {
  CommentRepository(super.httpClient, super.mainInterceptor);

  @override
  String get endpoint => 'comments';

  @override
  Comment Function(Map<String, dynamic> p1) get convertResponse => Comment.fromJson;

  Future<Comment> updateById(String id, String text) async {
    return convertResponse(
      await put<Map<String, dynamic>>(
        path: id,
        body: {'text': text},
      ),
    );
  }
}
