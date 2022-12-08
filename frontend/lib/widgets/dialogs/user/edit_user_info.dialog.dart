import 'package:flutter/material.dart';
import 'package:frontend/view_models/user.view_model.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';
import '../../components/text-input.component.dart';

class EditUserInfoDialog extends StatelessWidget {
  final User _user;

  const EditUserInfoDialog(this._user, {super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UserViewModel>();

    return AlertDialog(
      scrollable: true,
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
            child: TextInputComponent(
              onInput: viewModel.setFirstName,
              hintText: 'Имя',
              value: _user.firstName,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextInputComponent(
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

  static Widget onCreate(User user, UserViewModel viewModel) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => viewModel.copy(context),
      child: EditUserInfoDialog(user),
    );
  }
}
