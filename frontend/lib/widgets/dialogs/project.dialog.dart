import 'package:flutter/material.dart';
import 'package:frontend/models/project.dart';
import 'package:frontend/view_models/dialog/project_dialog.view_model.dart';
import 'package:provider/provider.dart';

import '../../di/app.module.dart';
import '../../models/user.dart';
import '../components/text.input.dart';

class ProjectDialog extends StatelessWidget {
  final Project? _project;

  bool get _isAuth {
    return _project != null;
  }

  const ProjectDialog(this._project, {super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProjectDialogViewModel>();

    return AlertDialog(
      scrollable: true,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.all(10),
      title: Center(
        child: Text('${_isAuth ? 'Изменение' : 'Создание'} проекта'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextInput(
              onInput: viewModel.setName,
              hintText: 'Название',
              value: _project?.name ?? '',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: viewModel.getUsers().map((User user) {
                return CheckboxListTile(
                  value: viewModel.isUserAdded(user.id),
                  onChanged: viewModel.changeMemberHandler(user.id),
                  title: Text('${user.firstName} ${user.lastName} (${user.email})'),
                );
              }).toList(),
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
          child: Text(_isAuth ? 'Изменить' : 'Создать'),
        ),
      ],
    );
  }

  static Widget onCreate({Project? project}) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<ProjectDialogViewModel>(param1: context, param2: project),
      child: ProjectDialog(project),
    );
  }
}
