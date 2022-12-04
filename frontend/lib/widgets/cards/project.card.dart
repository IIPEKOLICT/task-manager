import 'package:flutter/material.dart';
import 'package:frontend/models/project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ProjectCard({super.key, required this.project, this.onTap, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.folder, color: project.canEdit ? Colors.blue : Colors.grey),
          title: Text(project.name),
          subtitle: Text('${project.members.length} других участников'),
          onTap: onTap,
          trailing: project.canEdit
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(onPressed: onEdit, child: const Icon(Icons.edit, color: Colors.amber)),
                    TextButton(onPressed: onDelete, child: const Icon(Icons.delete, color: Colors.red)),
                  ],
                )
              : null,
          // isThreeLine: true,
        ),
      ),
    );
  }
}
