import 'package:flutter/material.dart';
import 'package:frontend/models/project.dart';
import 'package:frontend/view_models/dialog/project_dialog.view_model.dart';
import 'package:provider/provider.dart';

import '../../di/app.module.dart';
import '../../models/user.dart';
import '../components/text.input.dart';

class ProjectDialog extends StatelessWidget {
  final bool _isEdit;
  final Project? _project;

  const ProjectDialog(this._isEdit, this._project, {super.key});

  @override
  Widget build(BuildContext context) {
    final projectDialogViewModel = context.watch<ProjectDialogViewModel>();

    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.all(10),
      title: Center(
        child: Text('${_isEdit ? 'Изменение' : 'Создание'} проекта'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child:
                TextInput(onInput: projectDialogViewModel.setName, hintText: 'Название', value: _project?.name ?? ''),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: projectDialogViewModel.getUsers().map((User user) {
                return CheckboxListTile(
                  value: projectDialogViewModel.isUserAdded(user.id),
                  onChanged: projectDialogViewModel.changeMemberHandler(user.id),
                  title: Text('${user.firstName} ${user.lastName}'),
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
          onPressed: !projectDialogViewModel.isValid ? null : projectDialogViewModel.submitHandler(_isEdit),
          child: Text(_isEdit ? 'Изменить' : 'Создать'),
        ),
      ],
    );
  }

  static Widget onCreate(bool isEdit, {Project? project}) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<ProjectDialogViewModel>(param1: context, param2: project),
      child: ProjectDialog(isEdit, project),
    );
  }
}
