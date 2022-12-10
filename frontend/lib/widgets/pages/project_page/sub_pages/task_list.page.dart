import 'package:flutter/material.dart';
import 'package:frontend/enums/status.enum.dart';
import 'package:frontend/models/task.dart';
import 'package:frontend/view_models/task_list.view_model.dart';
import 'package:provider/provider.dart';

import '../../../../di/app.module.dart';
import '../../../../enums/priority.enum.dart';
import '../../../cards/task.card.dart';
import '../../../dialogs/task/create_task.dialog.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  Future<void> Function() _showEditStatusDialog(BuildContext context, Task task) {
    final viewModel = context.read<TaskListViewModel>();

    return () async {
      await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Изменить статус'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: StatusEnum.values.map((StatusEnum status) {
                return PopupMenuItem(
                  onTap: viewModel.updateStatusHandler(task.id, status),
                  textStyle: TextStyle(color: status == task.status ? Colors.white : Colors.grey),
                  child: Text(status.label),
                );
              }).toList(),
            ),
          );
        },
      );
    };
  }

  Future<void> Function() _showEditPriorityDialog(BuildContext context, Task task) {
    final viewModel = context.read<TaskListViewModel>();

    return () async {
      await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Изменить приоритет'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: PriorityEnum.values.map((PriorityEnum priority) {
                return PopupMenuItem(
                  onTap: viewModel.updatePriorityHandler(task.id, priority),
                  textStyle: TextStyle(color: priority == task.priority ? Colors.white : Colors.grey),
                  child: Text(priority.label),
                );
              }).toList(),
            ),
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

    return Scaffold(
      body: ListView(
        children: viewModel.isLoading
            ? const [LinearProgressIndicator()]
            : viewModel
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  static Widget onCreate() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<TaskListViewModel>(param1: context),
      child: const TaskListPage(),
    );
  }
}
