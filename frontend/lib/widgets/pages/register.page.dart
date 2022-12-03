import 'package:flutter/material.dart';
import 'package:frontend/di/app.module.dart';
import 'package:frontend/enums/route.enum.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../constants/ui.dart';
import '../../view_models/register.view_model.dart';
import '../components/default.button.dart';
import '../components/text.input.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<RegisterViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(appHeader),
      ),
      body: ListView(
        children: [
          Center(
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
                      'Регистрация',
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextInput(onInput: viewModel.setFirstName, hintText: 'Имя'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextInput(onInput: viewModel.setLastName, hintText: 'Фамилия'),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: DefaultButton(
                      title: 'Уже есть аккаунт',
                      onTap: () => context.go(RouteEnum.login.value),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: DefaultButton(
                      title: 'Регистрация',
                      onTap: viewModel.isValid ? viewModel.onSubmit : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget onCreate() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<RegisterViewModel>(param1: context),
      child: const RegisterPage(),
    );
  }
}
