import 'package:frontend/models/attachment.dart';
import 'package:frontend/view_models/state/base/sharable_state.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AttachmentState extends SharableState<Attachment> {}
