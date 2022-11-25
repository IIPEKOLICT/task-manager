import 'package:flutter/material.dart';
import 'package:frontend/di/app.module.dart';
import 'package:frontend/widgets/app.dart';

void main() async {
  await configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}
