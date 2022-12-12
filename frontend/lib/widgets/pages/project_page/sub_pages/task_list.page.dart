import 'package:flutter/material.dart';
import 'package:frontend/models/task.dart';
import 'package:frontend/view_models/task_list.view_model.dart';
import 'package:provider/provider.dart';

import '../../../../di/app.module.dart';
import '../../../cards/task.card.dart';
import '../../../components/list.component.dart';
import '../../../dialogs/task/create_task.dialog.dart';
import '../../../dialogs/task/edit_task_popup.dialog.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  Future<void> Function() _showEditStatusDialog(BuildContext context, Task task) {
    return () async {
      final viewModel = context.read<TaskListViewModel>();

      await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return EditTaskPopupDialog.createStatusDialog(
            onPick: viewModel.updateStatusHandler(task.id),
            task: task,
          );
        },
      );
    };
  }

  Future<void> Function() _showEditPriorityDialog(BuildContext context, Task task) {
    return () async {
      final viewModel = context.read<TaskListViewModel>();

      await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return EditTaskPopupDialog.createPriorityDialog(
            onPick: viewModel.updatePriorityHandler(task.id),
            task: task,
          );
        },
      );
    };
  }

  Future<void> Function() _showCreateDialog(BuildContext context) {
    return () async {
      await showDialog(
        context: context,
        builder: (BuildContext ctx) => CreateTaskDialog.onCreate(),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TaskListViewModel>();

    return ListComponent(
      isLoading: viewModel.isLoading,
      items: viewModel
          .getTasks()
          .map(
            (Task task) => TaskCard(
              task: task,
              onTap: viewModel.pickTaskHandler(task.id),
              onEditStatus: _showEditStatusDialog(context, task),
              onEditPriority: _showEditPriorityDialog(context, task),
              onDelete: viewModel.deleteById(task.id),
            ),
          )
          .toList(),
      placeholder: 'Нет задач',
      onAdd: _showCreateDialog(context),
    );
  }

  static Widget onCreate() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<TaskListViewModel>(param1: context),
      child: const TaskListPage(),
    );
  }
}
