import 'package:flutter/material.dart';

mixin LoadableViewModel on ChangeNotifier {
  bool _isLoading = true;

  bool get isLoading {
    return _isLoading;
  }

  @protected
  void toggleIsLoading() {
    if (_isLoading) _isLoading = false;
  }

  @protected
  void loaderSubscriber(_) {
    toggleIsLoading();
    notifyListeners();
  }
}
