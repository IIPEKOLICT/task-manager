import 'package:flutter/material.dart';
import 'package:frontend/models/task.dart';
import 'package:frontend/view_models/task.view_model.dart';
import 'package:frontend/widgets/dialogs/task/edit_task_blocked_by.dialog.dart';
import 'package:frontend/widgets/dialogs/task/edit_task_info.dialog.dart';
import 'package:frontend/widgets/dialogs/task/edit_task_tags.dialog.dart';
import 'package:provider/provider.dart';

import '../../../../di/app.module.dart';
import '../../../../enums/priority.enum.dart';
import '../../../../enums/status.enum.dart';
import '../../../../models/user.dart';
import '../../../components/tag.component.dart';

class TaskInfoPage extends StatelessWidget {
  const TaskInfoPage({super.key});

  Future<void> Function() _showEditStatusDialog(BuildContext context, Task task) {
    return () async {
      final viewModel = context.read<TaskViewModel>();

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
    return () async {
      final viewModel = context.read<TaskViewModel>();

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

  Future<void> Function() _showEditAssignedToDialog(BuildContext context, Task task) {
    return () async {
      final viewModel = context.read<TaskViewModel>();

      await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Изменить исполнителя'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: viewModel.getProjectUsers().map((User user) {
                return PopupMenuItem(
                  onTap: viewModel.updateAssignedToHandler(task.id, user),
                  textStyle: TextStyle(
                    color: task.assignedTo?.id == user.id ? Colors.white : Colors.grey,
                  ),
                  child: Text('${user.firstName} ${user.lastName}'),
                );
              }).toList(),
            ),
          );
        },
      );
    };
  }

  Future<void> Function() _showEditInfoDialog(BuildContext context) {
    return () async {
      await showDialog(
        context: context,
        builder: (BuildContext ctx) => EditTaskInfoDialog.onCreate(context.read()),
      );
    };
  }

  Future<void> Function() _showEditTagsDialog(BuildContext context) {
    return () async {
      await showDialog(
        context: context,
        builder: (BuildContext ctx) => EditTaskTagsDialog.onCreate(context.read()),
      );
    };
  }

  Future<void> Function() _showEditBlockedByDialog(BuildContext context) {
    return () async {
      await showDialog(
        context: context,
        builder: (BuildContext ctx) => EditTaskBlockedByDialog.onCreate(context.read()),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TaskViewModel>();
    final Task? task = viewModel.getTaskOrNull();
    final List<Task> blockedByTasks = viewModel.getBlockedByTasks();
    final User? assignedUser = task?.assignedTo;

    return ListView(
      children: task == null
          ? const [LinearProgressIndicator()]
          : [
              ListTile(
                leading: const Icon(Icons.info),
                title: Text(task.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.description.isEmpty ? '(нет описания)' : task.description),
                    Text('Ожидаемое время выполнения: ${task.expectedHours} ч.'),
                  ],
                ),
                trailing: TextButton(
                  onPressed: _showEditInfoDialog(context),
                  child: const Icon(Icons.edit),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.priority_high),
                title: Text('${task.priority.label} приоритет'),
                trailing: TextButton(
                  onPressed: _showEditPriorityDialog(context, task),
                  child: const Icon(Icons.edit),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.task_alt),
                title: Text('Статус: ${task.status.label.toLowerCase()}'),
                trailing: TextButton(
                  onPressed: _showEditStatusDialog(context, task),
                  child: const Icon(Icons.edit),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.man),
                title: const Text('Исполнитель'),
                subtitle: Text(
                  assignedUser == null ? 'Не задан' : '${assignedUser.firstName} ${assignedUser.lastName}',
                ),
                trailing: TextButton(
                  onPressed: _showEditAssignedToDialog(context, task),
                  child: const Icon(Icons.edit),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.tag),
                title: task.tags.isEmpty
                    ? const Text('Нет тегов')
                    : Wrap(
                        children: task.tags.map((e) => TagComponent(e)).toList(),
                      ),
                trailing: TextButton(
                  onPressed: _showEditTagsDialog(context),
                  child: const Icon(Icons.edit),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.block),
                title: blockedByTasks.isEmpty
                    ? const Text('Нет блокирующих задач')
                    : Wrap(
                        children: blockedByTasks.map((Task t) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                            child: Chip(
                              label: Text(t.title),
                            ),
                          );
                        }).toList(),
                      ),
                trailing: TextButton(
                  onPressed: _showEditBlockedByDialog(context),
                  child: const Icon(Icons.edit),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.comment),
                title: Text('Число комментариев: ${task.commentsAmount}'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.note),
                title: Text('Число заметок: ${task.notesAmount}'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.attachment),
                title: Text('Число вложений: ${task.attachmentsAmount}'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.work),
                title: Text(
                  'Выполняется ${Duration(milliseconds: task.trackedTime.toInt()).inHours} часов',
                ),
              ),
            ],
    );
  }

  static Widget onCreate() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<TaskViewModel>(param1: context, param2: true).create(),
      child: const TaskInfoPage(),
    );
  }
}
