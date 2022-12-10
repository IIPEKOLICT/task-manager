import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:frontend/enums/priority.enum.dart';
import 'package:frontend/view_models/task.view_model.dart';
import 'package:provider/provider.dart';

import '../../../di/app.module.dart';
import '../../../enums/status.enum.dart';
import '../../../models/tag.dart';
import '../../../models/task.dart';
import '../../../models/user.dart';
import '../../components/text_input.component.dart';

class CreateTaskDialog extends StatelessWidget {
  const CreateTaskDialog({super.key});

  List<Widget> _getAssignedToRowWidgets(TaskViewModel viewModel) {
    final List<Widget> list = [
      const Text('Исполнитель'),
      const SizedBox(width: 10),
    ];

    final List<User> projectUsers = viewModel.getProjectUsers();

    if (projectUsers.isNotEmpty) {
      list.add(
        DropdownButton<User>(
          value: viewModel.getAssignedToOrNull(),
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          onChanged: viewModel.setAssignedTo,
          items: [
            const DropdownMenuItem(
              value: null,
              child: Text('Выбрать'),
            ),
            ...projectUsers.map((User user) {
              return DropdownMenuItem(
                value: user,
                child: Text(user.username),
              );
            }).toList(),
          ],
        ),
      );
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TaskViewModel>();

    return AlertDialog(
      scrollable: true,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.all(10),
      title: const Center(
        child: Text('Создать задачу'),
      ),
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextInputComponent(
              onInput: viewModel.setTitle,
              hintText: 'Название',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextInputComponent(
              onInput: viewModel.setDescription,
              hintText: 'Описание',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Время выполнения (ч)',
                labelText: 'Время выполнения (ч)',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [services.FilteringTextInputFormatter.digitsOnly], // Only numbers
              onChanged: viewModel.setExpectedHours, // can be entered
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Приоритет'),
                DropdownButton<PriorityEnum>(
                  value: viewModel.getPriority(),
                  icon: const Icon(Icons.arrow_drop_down),
                  elevation: 16,
                  onChanged: viewModel.setPriority,
                  items: PriorityEnum.values.map((PriorityEnum priority) {
                    return DropdownMenuItem(
                      value: priority,
                      child: Text(priority.label),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Статус'),
                DropdownButton<StatusEnum>(
                  value: viewModel.getStatus(),
                  icon: const Icon(Icons.arrow_drop_down),
                  elevation: 16,
                  onChanged: viewModel.setStatus,
                  items: StatusEnum.values.map((StatusEnum status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status.label),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _getAssignedToRowWidgets(viewModel),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Теги',
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                ...viewModel.getProjectTags().map((Tag tag) {
                  return CheckboxListTile(
                    value: viewModel.isTagAdded(tag.id),
                    onChanged: viewModel.changeTagHandler(tag.id),
                    title: Text(tag.name),
                  );
                }).toList(),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Блокирующие задачи',
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                ...viewModel.getProjectTasks().map((Task task) {
                  return CheckboxListTile(
                    value: viewModel.isBlockedByAdded(task.id),
                    onChanged: viewModel.changeBlockedByHandler(task.id),
                    title: Text(task.title),
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
          onPressed: !viewModel.isValidForCreate ? null : viewModel.createHandler,
          child: const Text('Создать'),
        ),
      ],
    );
  }

  static Widget onCreate() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<TaskViewModel>(param1: context, param2: false).create(),
      child: const CreateTaskDialog(),
    );
  }
}
