import 'package:flutter/material.dart';
import 'package:frontend/enums/priority.enum.dart';
import 'package:frontend/enums/status.enum.dart';
import 'package:frontend/models/user.dart';

import '../../../models/task.dart';

class EditTaskPopupDialog<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final void Function(T) onPick;
  final bool Function(T) isCheckedHandler;
  final String Function(T) labelBuilder;

  const EditTaskPopupDialog({
    super.key,
    required this.title,
    required this.items,
    required this.onPick,
    required this.isCheckedHandler,
    required this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: items.map((T item) {
          return PopupMenuItem(
            onTap: () => onPick(item),
            textStyle: TextStyle(
              color: isCheckedHandler(item) ? Colors.white : Colors.grey,
            ),
            child: Text(labelBuilder(item)),
          );
        }).toList(),
      ),
    );
  }

  static EditTaskPopupDialog<PriorityEnum> createPriorityDialog({
    required void Function(PriorityEnum) onPick,
    required Task task,
  }) {
    return EditTaskPopupDialog(
      title: 'Изменить приоритет',
      items: PriorityEnum.values,
      onPick: onPick,
      isCheckedHandler: (PriorityEnum priority) => priority == task.priority,
      labelBuilder: (PriorityEnum priority) => priority.label,
    );
  }

  static EditTaskPopupDialog<StatusEnum> createStatusDialog({
    required void Function(StatusEnum) onPick,
    required Task task,
  }) {
    return EditTaskPopupDialog(
      title: 'Изменить статус',
      items: StatusEnum.values,
      onPick: onPick,
      isCheckedHandler: (StatusEnum status) => status == task.status,
      labelBuilder: (StatusEnum status) => status.label,
    );
  }

  static EditTaskPopupDialog<User> createAssignedToDialog({
    required void Function(User) onPick,
    required List<User> users,
    required Task task,
  }) {
    return EditTaskPopupDialog(
      title: 'Изменить исполнителя',
      items: users,
      onPick: onPick,
      isCheckedHandler: (User user) => task.assignedTo?.id == user.id,
      labelBuilder: (User user) => user.username,
    );
  }
}
