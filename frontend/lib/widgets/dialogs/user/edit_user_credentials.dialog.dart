import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../di/app.module.dart';
import '../../../models/user.dart';
import '../../../view_models/dialog/edit_user_dialog.view_model.dart';
import '../../components/text.input.dart';

class EditUserCredentialsDialog extends StatelessWidget {
  final User _user;
  final bool _isPassword;

  const EditUserCredentialsDialog(this._user, this._isPassword, {super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<EditUserDialogViewModel>();

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
          onPressed: !viewModel.isCredentialsValid ? null : viewModel.updateCredentialsHandler,
          child: const Text('Применить'),
        ),
      ],
    );
  }

  static Widget onCreate(User user, bool isPassword) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<EditUserDialogViewModel>(param1: context),
      child: EditUserCredentialsDialog(user, isPassword),
    );
  }
}
