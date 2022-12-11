import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/constants/ui.dart';
import 'package:frontend/widgets/shackbars/success.snackbar.dart';
import 'package:provider/provider.dart';

import '../../di/app.module.dart';
import '../../view_models/auth.view_model.dart';
import '../dialogs/auth.dialog.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  Future<void> Function() _showDialog(BuildContext context, {bool isRegister = false}) {
    return () async {
      await showDialog(
        context: context,
        builder: (BuildContext ctx) => AuthDialog.onCreate(context.read(), isRegister),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AuthViewModel>();
    final bool isMobile = Platform.isAndroid || Platform.isIOS;

    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        leading: TextButton(
          onPressed: () => SystemNavigator.pop(animated: true),
          child: const Icon(Icons.arrow_back_sharp),
        ),
      ),
      body: viewModel.isLoading
          ? const Center(
              widthFactor: double.infinity,
              heightFactor: double.infinity,
              child: CircularProgressIndicator(
                value: null,
                strokeWidth: 5,
              ),
            )
          : Column(
              mainAxisAlignment: isMobile ? MainAxisAlignment.end : MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 10),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.thumb_up_alt_sharp,
                      color: Colors.green,
                      size: 120,
                    ),
                    onTap: () => SuccessSnackbar.show('Java лучший язык!', context),
                  ),
                ),
                ListTile(
                  title: ElevatedButton(
                    onPressed: _showDialog(context),
                    child: const Text('Войти'),
                  ),
                ),
                ListTile(
                  title: ElevatedButton(
                    onPressed: _showDialog(context, isRegister: true),
                    child: const Text('Зарегистрироваться'),
                  ),
                ),
              ],
            ),
    );
  }

  static Widget onCreate() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<AuthViewModel>(param1: context).create(),
      child: const AuthPage(),
    );
  }
}
