import 'package:frontend/models/note.dart';
import 'package:frontend/state/base/sharable_state.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class NoteState extends SharableState<Note> {}
