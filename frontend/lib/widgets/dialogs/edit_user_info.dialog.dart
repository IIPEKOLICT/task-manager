import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../di/app.module.dart';
import '../../models/user.dart';
import '../../view_models/dialog/edit_user_dialog.view_model.dart';
import '../components/text.input.dart';

class EditUserInfoDialog extends StatelessWidget {
  final User _user;

  const EditUserInfoDialog(this._user, {super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<EditUserDialogViewModel>();

    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.all(10),
      title: const Center(
        child: Text('Изменить имя/фамилию'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextInput(
              onInput: viewModel.setFirstName,
              hintText: 'Имя',
              value: _user.firstName,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextInput(
              onInput: viewModel.setLastName,
              hintText: 'Фамилия',
              value: _user.lastName,
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
          onPressed: !viewModel.isInfoValid ? null : viewModel.updateInfoHandler,
          child: const Text('Применить'),
        ),
      ],
    );
  }

  static Widget onCreate(User user) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<EditUserDialogViewModel>(param1: context),
      child: EditUserInfoDialog(user),
    );
  }
}
