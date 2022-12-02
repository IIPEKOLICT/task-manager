import 'package:frontend/view_models/state/base/entities_state.dart';
import 'package:injectable/injectable.dart';

import '../../models/project.dart';

@LazySingleton()
class ProjectState extends EntitiesState<Project> {}
