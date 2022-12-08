import 'package:frontend/dtos/response/delete.dto.dart';
import 'package:frontend/models/note.dart';
import 'package:injectable/injectable.dart';

import 'base/base.repository.dart';

@LazySingleton()
class NoteRepository extends BaseRepository {
  NoteRepository(super.httpClient, super.mainInterceptor);

  @override
  String get endpoint => 'notes';

  Future<Note> getById(String id) async {
    return Note.fromJson(await get<Map<String, dynamic>>(path: id));
  }

  Future<Note> updateName(String id, String header, String text) async {
    return Note.fromJson(
      await put<Map<String, dynamic>>(
        path: id,
        body: {
          'header': header,
          'text': text,
        },
      ),
    );
  }

  Future<String> deleteById(String id) async {
    return DeleteDto.fromJson(await delete<Map<String, dynamic>>(path: id)).id;
  }
}
