import 'package:flutter/material.dart';
import 'package:frontend/widgets/components/tag.component.dart';

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

  List<Widget> _renderButtons(bool isMobileResolution) {
    final List<Widget> publicWidgets = [];

    if (!isMobileResolution) {
      publicWidgets.addAll([
        TextButton(
          onPressed: onEditStatus,
          child: Icon(Icons.task_alt, color: task.status.color),
        ),
        TextButton(
          onPressed: onEditPriority,
          child: Icon(Icons.priority_high, color: task.priority.color),
        ),
      ]);
    }

    if (task.canEdit) {
      publicWidgets.add(
        TextButton(
          onPressed: onDelete,
          child: const Icon(Icons.delete, color: Colors.red),
        ),
      );
    }

    return publicWidgets;
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobileResolution = MediaQuery.of(context).size.width <= 400;

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.task, color: task.color),
          title: Text(task.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.description.isEmpty ? '(нет описания)' : task.description),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Wrap(
                  children: task.tags.map((e) => TagComponent(e)).toList(),
                ),
              ),
            ],
          ),
          onTap: onTap,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: _renderButtons(isMobileResolution),
          ),
        ),
      ),
    );
  }
}
