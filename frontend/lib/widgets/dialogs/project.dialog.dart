import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../view_models/project.view_model.dart';
import '../components/text_input.component.dart';

class ProjectDialog extends StatelessWidget {
  const ProjectDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProjectViewModel>();

    return AlertDialog(
      scrollable: true,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.all(10),
      title: Center(
        child: Text('${viewModel.isEdit ? 'Изменение' : 'Создание'} проекта'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextInputComponent(
              onInput: viewModel.setName,
              hintText: 'Название',
              value: viewModel.getName(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Участники',
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                ...viewModel.getUsers().map((User user) {
                  return CheckboxListTile(
                    value: viewModel.isUserAdded(user.id),
                    onChanged: viewModel.changeMemberHandler(user.id),
                    title: Text('${user.firstName} ${user.lastName} (${user.email})'),
                  );
                }).toList(),
              ],
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
          onPressed: !viewModel.isValid ? null : viewModel.submitHandler,
          child: Text(viewModel.isEdit ? 'Изменить' : 'Создать'),
        ),
      ],
    );
  }

  static Widget onCreate(ProjectViewModel viewModel) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => viewModel.copy(context),
      child: const ProjectDialog(),
    );
  }
}
