import 'package:flutter/material.dart';
import 'package:frontend/di/app.module.dart';
import 'package:frontend/enums/route.enum.dart';
import 'package:frontend/view_models/login.view_model.dart';
import 'package:frontend/widgets/components/default.button.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../constants/ui.dart';
import '../components/text.input.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<LoginViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(appHeader),
      ),
      body: Center(
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Вход в аккаунт',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextInput(onInput: viewModel.setEmail, hintText: 'E-mail'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextInput(onInput: viewModel.setPassword, hintText: 'Пароль', isPassword: true),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: DefaultButton(
                  title: 'Зарегистрироваться',
                  onTap: () => context.go(RouteEnum.register.value),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: DefaultButton(
                  title: 'Войти',
                  onTap: viewModel.isValid ? viewModel.login : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget onCreate() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<LoginViewModel>(param1: context),
      child: const LoginPage(),
    );
  }
}
