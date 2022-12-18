import 'package:frontend/models/note.dart';
import 'package:frontend/repositories/base/read_delete.repository.dart';
import 'package:injectable/injectable.dart';

import 'base/base.repository.dart';

@LazySingleton()
class NoteRepository extends BaseRepository with ReadDeleteRepository<Note> {
  NoteRepository(super.httpClient, super.mainInterceptor);

  @override
  String get endpoint => 'notes';

  @override
  Note Function(Map<String, dynamic> p1) get convertResponse => Note.fromJson;

  Future<Note> updateById(String id, String header, String text) async {
    return convertResponse(
      await put<Map<String, dynamic>>(
        path: id,
        body: {
          'header': header,
          'text': text,
        },
      ),
    );
  }
}
