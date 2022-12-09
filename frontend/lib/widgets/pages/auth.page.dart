import 'package:flutter/material.dart';
import 'package:frontend/constants/ui.dart';
import 'package:provider/provider.dart';

import '../../di/app.module.dart';
import '../../view_models/auth.view_model.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
      ),
      body: const Center(
        widthFactor: double.infinity,
        heightFactor: double.infinity,
        child: CircularProgressIndicator(
          value: null,
          strokeWidth: 5,
        ),
      ),
    );
  }

  static Widget onCreate() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<AuthViewModel>(param1: context),
      lazy: false,
      child: const AuthPage(),
    );
  }
}
