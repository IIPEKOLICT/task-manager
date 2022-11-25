import 'package:flutter/material.dart';
import 'package:frontend/di/app.module.dart';

import '../../viewModels/auth.view_model.dart';

class LoginDialog extends StatelessWidget {
  final VoidCallback onClose;

  LoginDialog({super.key, required this.onClose});

  final AuthViewModel authViewModel = injector.get();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text('Войти в систему'),
      ),
      content: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextField(
              autofocus: true,
              onChanged: authViewModel.setEmail,
              autocorrect: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'E-mail'
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextField(
              autofocus: false,
              onChanged: authViewModel.setPassword,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Пароль'
              ),
            ),
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: onClose,
          child: const Text("Закрыть"),
        ),
        OutlinedButton(
          child: const Text("Войти"),
          onPressed: () async {
            try {
              await authViewModel.login();
              onClose();
            } catch (e) {
              ScaffoldMessenger
                .of(context)
                .showSnackBar(const SnackBar(content: Text("Ошибка входа")));
              onClose();
            }
          },
        ),
      ],
    );
  }
}