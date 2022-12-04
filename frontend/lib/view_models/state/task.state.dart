import 'package:frontend/view_models/state/base/entities_state.dart';
import 'package:injectable/injectable.dart';

import '../../models/task.dart';

@LazySingleton()
class TaskState extends EntitiesState<Task> {}
