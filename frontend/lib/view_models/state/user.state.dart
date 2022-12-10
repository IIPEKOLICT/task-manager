import 'package:frontend/models/user.dart';
import 'package:frontend/view_models/state/base/sharable_state.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class UserState extends SharableState<User> {}
