import 'package:frontend/dtos/response/delete.dto.dart';
import 'package:frontend/models/comment.dart';
import 'package:injectable/injectable.dart';

import 'base/base.repository.dart';

@LazySingleton()
class CommentRepository extends BaseRepository {
  CommentRepository(super.httpClient, super.mainInterceptor);

  @override
  String get endpoint => 'comments';

  Future<Comment> getById(String id) async {
    return Comment.fromJson(await get<Map<String, dynamic>>(path: id));
  }

  Future<Comment> updateById(String id, String text) async {
    return Comment.fromJson(
      await put<Map<String, dynamic>>(
        path: id,
        body: {'text': text},
      ),
    );
  }

  Future<String> deleteById(String id) async {
    return DeleteDto.fromJson(await delete<Map<String, dynamic>>(path: id)).id;
  }
}
