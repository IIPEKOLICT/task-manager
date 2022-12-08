import 'package:flutter/material.dart';
import 'package:frontend/view_models/base/base.view_model.dart';

abstract class PageViewModel<V extends BaseViewModel> extends BaseViewModel {
  PageViewModel(super.context);

  V create();
  V copy(BuildContext context);
}
