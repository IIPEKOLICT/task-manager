import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../di/app.module.dart';
import '../../../models/tag.dart';
import '../../../view_models/task.view_model.dart';

class EditTaskTagsDialog extends StatelessWidget {
  const EditTaskTagsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TaskViewModel>();

    return AlertDialog(
      scrollable: true,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.all(10),
      title: const Center(
        child: Text('Изменить теги'),
      ),
      content: Column(
        children: viewModel.getProjectTags().map((Tag tag) {
          return CheckboxListTile(
            value: viewModel.isTagAdded(tag.id),
            onChanged: viewModel.changeTagHandler(tag.id),
            title: Text(tag.name),
          );
        }).toList(),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Закрыть'),
        ),
        ElevatedButton(
          onPressed: viewModel.updateTagsHandler,
          child: const Text('Применить'),
        ),
      ],
    );
  }

  static Widget onCreate() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<TaskViewModel>(param1: context, param2: true),
      child: const EditTaskTagsDialog(),
    );
  }
}
