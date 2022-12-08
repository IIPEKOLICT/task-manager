import 'package:flutter/material.dart';

import '../../models/tag.dart';

class TagCard extends StatelessWidget {
  final Tag tag;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TagCard({super.key, required this.tag, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.tag, color: tag.color),
          title: Text(tag.name),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(onPressed: onEdit, child: const Icon(Icons.edit, color: Colors.amber)),
              TextButton(onPressed: onDelete, child: const Icon(Icons.delete, color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
