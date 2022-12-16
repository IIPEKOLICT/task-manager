import 'package:frontend/state/base/sharable_state.dart';
import 'package:injectable/injectable.dart';

import '../../models/work.dart';

@LazySingleton()
class WorkState extends SharableState<Work> {}
