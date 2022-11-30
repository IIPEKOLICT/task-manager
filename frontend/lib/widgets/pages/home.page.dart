import 'package:flutter/material.dart';
import 'package:frontend/constants/ui.dart';
import 'package:provider/provider.dart';

import '../../di/app.module.dart';
import '../../view_models/auth.view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var authViewModel = context.watch<AuthViewModel>();

    const loader = CircularProgressIndicator(
      value: null,
      strokeWidth: 5,
    );

    final logoutButton = ElevatedButton(
        onPressed: authViewModel.logout,
        child: const Text('Выйти')
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(appHeader),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [authViewModel.isLoading ? loader : logoutButton],
        ),
      ),
    );
  }

  static Widget onCreate() {
     return ChangeNotifierProvider(
       create: (BuildContext context) => injector.get<AuthViewModel>(param1: context),
       child: const HomePage(),
     );
   }
}