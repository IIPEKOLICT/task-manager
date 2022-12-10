import 'package:flutter/material.dart';
import 'package:frontend/models/work.dart';

class WorkCard extends StatelessWidget {
  final Work work;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const WorkCard({super.key, required this.work, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.work),
          title: Text(work.createdBy?.username ?? 'Анонимус'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(work.description),
              Text(work.renderDates()),
            ],
          ),
          trailing: work.canEdit
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: onEdit,
                      child: const Icon(
                        Icons.edit,
                        color: Colors.amber,
                      ),
                    ),
                    TextButton(
                      onPressed: onDelete,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                )
              : null,
        ),
      ),
    );
  }
}
