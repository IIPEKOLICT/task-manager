import 'package:flutter/material.dart';
import 'package:frontend/enums/priority.enum.dart';
import 'package:frontend/enums/status.enum.dart';

import '../../models/tag.dart';
import '../../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;
  final VoidCallback? onEditPriority;
  final VoidCallback? onEditStatus;
  final VoidCallback? onDelete;

  const TaskCard({
    super.key,
    required this.task,
    this.onTap,
    this.onEditPriority,
    this.onEditStatus,
    this.onDelete,
  });

  Color get _priorityColor {
    return PriorityEnum.values
        .firstWhere(
          (element) => element.value == task.priority,
          orElse: () => PriorityEnum.normal,
        )
        .color;
  }

  Color get _statusColor {
    return StatusEnum.values
        .firstWhere(
          (element) => element.value == task.status,
          orElse: () => StatusEnum.todo,
        )
        .color;
  }

  List<Widget> get _buttons {
    final List<Widget> publicWidgets = [
      TextButton(onPressed: onEditStatus, child: Icon(Icons.task_alt, color: _statusColor)),
      TextButton(onPressed: onEditPriority, child: Icon(Icons.priority_high, color: _priorityColor)),
    ];

    if (task.canEdit) {
      publicWidgets.add(TextButton(onPressed: onDelete, child: const Icon(Icons.delete, color: Colors.red)));
    }

    return publicWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.task, color: task.color),
          title: Text(task.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.description),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: task.tags.map(
                    (Tag tag) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: Chip(
                          labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                          label: Text(tag.name),
                          backgroundColor: tag.color,
                          elevation: 5,
                          shadowColor: Colors.grey[60],
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
          onTap: onTap,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: _buttons,
          ),
        ),
      ),
    );
  }
}
