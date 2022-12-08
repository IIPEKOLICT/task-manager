import 'package:frontend/view_models/state/base/sharable_state.dart';
import 'package:injectable/injectable.dart';

import '../../models/project.dart';

@LazySingleton()
class ProjectState extends SharableState<Project> {}
