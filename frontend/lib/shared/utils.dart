import 'package:flutter/material.dart';

import '../constants/ui.dart';

bool isMobileResolution(BuildContext context) {
  return MediaQuery.of(context).size.width == mobileResolution;
}
