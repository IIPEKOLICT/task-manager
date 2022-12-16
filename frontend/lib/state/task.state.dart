import 'package:frontend/state/base/sharable_state.dart';
import 'package:injectable/injectable.dart';

import '../../models/task.dart';

@LazySingleton()
class TaskState extends SharableState<Task> {}
