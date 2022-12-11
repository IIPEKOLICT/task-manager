import 'package:flutter/material.dart';
import 'package:frontend/view_models/auth.view_model.dart';
import 'package:provider/provider.dart';

import '../components/text_input.component.dart';

class AuthDialog extends StatelessWidget {
  final bool _isRegister;

  const AuthDialog(this._isRegister, {super.key});

  List<Widget> _getInputs(BuildContext context) {
    final viewModel = context.read<AuthViewModel>();

    final List<Widget> list = [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextInputComponent(
          onInput: viewModel.setEmail,
          hintText: 'E-mail',
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextInputComponent(
          onInput: viewModel.setPassword,
          hintText: 'Пароль',
          isPassword: true,
        ),
      ),
    ];

    if (_isRegister) {
      list.addAll([
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextInputComponent(
            onInput: viewModel.setFirstName,
            hintText: 'Имя',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextInputComponent(
            onInput: viewModel.setLastName,
            hintText: 'Фамилия',
          ),
        ),
      ]);
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AuthViewModel>();

    return AlertDialog(
      scrollable: true,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.all(10),
      title: Center(
        child: Text(_isRegister ? 'Регистрация' : 'Вход в аккаунт'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _getInputs(context),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Закрыть'),
        ),
        ElevatedButton(
          onPressed: viewModel.submitHandler(_isRegister),
          child: const Text('ОК'),
        ),
      ],
    );
  }

  static Widget onCreate(AuthViewModel viewModel, bool isRegister) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => viewModel.copy(context),
      child: AuthDialog(isRegister),
    );
  }
}
