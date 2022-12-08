import 'package:flutter/material.dart';
import 'package:frontend/view_models/user.view_model.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';
import '../../components/text.input.dart';

class EditUserCredentialsDialog extends StatelessWidget {
  final User _user;
  final bool _isPassword;

  const EditUserCredentialsDialog(this._user, this._isPassword, {super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UserViewModel>();

    return AlertDialog(
      scrollable: true,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.all(10),
      title: Center(
        child: Text('Изменить ${_isPassword ? 'пароль' : 'E-mail'}'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextInput(
              onInput: _isPassword ? viewModel.setPassword : viewModel.setEmail,
              hintText: _isPassword ? 'Пароль' : 'E-mail',
              value: _isPassword ? '' : _user.email,
              isPassword: _isPassword,
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Закрыть'),
        ),
        ElevatedButton(
          onPressed: !viewModel.isCredentialsValid(_isPassword) ? null : viewModel.updateCredentialsHandler,
          child: const Text('Применить'),
        ),
      ],
    );
  }

  static Widget onCreate(User user, bool isPassword, UserViewModel viewModel) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => viewModel.copy(context),
      child: EditUserCredentialsDialog(user, isPassword),
    );
  }
}
