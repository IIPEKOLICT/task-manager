import 'package:flutter/material.dart';

import '../../widgets/components/exception.snackbar.dart';

abstract class BaseViewModel extends ChangeNotifier {
  @protected
  final BuildContext context;

  BaseViewModel(this.context);

  @protected
  void onException(String message) {
    ExceptionSnackbar.show(message, context);
  }
}