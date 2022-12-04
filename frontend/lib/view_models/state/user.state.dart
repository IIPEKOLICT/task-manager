import 'package:frontend/models/user.dart';
import 'package:frontend/view_models/state/base/entities_state.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class UserState extends EntitiesState<User> {}
