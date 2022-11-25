import 'package:flutter/material.dart';
import 'package:frontend/di/app.module.dart';
import 'package:frontend/repositories/auth.repository.dart';
import 'package:frontend/viewModels/auth.view_model.dart';
import 'package:provider/provider.dart';

import '../dialogs/login.dialog.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthRepository authRepository = injector.get();

  final ButtonStyle _btnStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(10),
    textStyle: const TextStyle(fontSize: 20)
  );

  _onLogin(BuildContext context) {
    return () async => showDialog(
      context: context,
      builder: (_) => LoginDialog(onClose: _onCloseDialog(context)),
    );
  }

  _onCloseDialog(BuildContext context) {
    return () {
      Navigator.of(context).pop();
    };
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<AuthViewModel>();

    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(viewModel.getToken() ?? 'Empty'),
            Container(
              padding: const EdgeInsets.all(5),
              width: double.infinity,
              child: ElevatedButton(
                style: _btnStyle,
                onPressed: _onLogin(context),
                child: const Text('Войти')
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              width: double.infinity,
              child: ElevatedButton(
                style: _btnStyle,
                onPressed: () async => viewModel.setToken('Register'),
                child: const Text('Зарегистрироваться')
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget create() {
    return ChangeNotifierProvider(
        create: (_) => injector.get<AuthViewModel>(),
        child: LoginPage(),
    );
  }
}