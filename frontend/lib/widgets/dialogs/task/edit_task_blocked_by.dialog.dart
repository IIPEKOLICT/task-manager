import 'package:flutter/material.dart';
import 'package:frontend/view_models/task.view_model.dart';
import 'package:provider/provider.dart';

import '../../../models/task.dart';

class EditTaskBlockedByDialog extends StatelessWidget {
  const EditTaskBlockedByDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TaskViewModel>();

    return AlertDialog(
      scrollable: true,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.all(10),
      title: const Center(
        child: Text('Изменить блокирующие задачи'),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: viewModel.getAllowedBlockedByTasks().map((Task task) {
          return CheckboxListTile(
            value: viewModel.isBlockedByAdded(task.id),
            onChanged: viewModel.changeBlockedByHandler(task.id),
            title: Text(task.title),
          );
        }).toList(),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Закрыть'),
        ),
        ElevatedButton(
          onPressed: viewModel.updateBlockedByHandler,
          child: const Text('Применить'),
        ),
      ],
    );
  }

  static Widget onCreate(TaskViewModel viewModel) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => viewModel.copy(context),
      child: const EditTaskBlockedByDialog(),
    );
  }
}
