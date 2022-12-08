import 'package:flutter/material.dart';
import 'package:frontend/models/comment.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CommentCard({super.key, required this.comment, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.comment),
          title: Text(comment.createdBy?.username ?? 'Анонимус'),
          subtitle: Text(comment.text),
          trailing: comment.canEdit
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(onPressed: onEdit, child: const Icon(Icons.edit, color: Colors.amber)),
                    TextButton(onPressed: onDelete, child: const Icon(Icons.delete, color: Colors.red)),
                  ],
                )
              : null,
        ),
      ),
    );
  }
}
