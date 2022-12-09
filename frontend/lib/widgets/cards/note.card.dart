import 'package:flutter/material.dart';
import 'package:frontend/models/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const NoteCard({super.key, required this.note, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.note_alt),
          title: Text(note.createdBy?.username ?? 'Анонимус'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note.header),
              Text(note.text),
            ],
          ),
          trailing: note.canEdit
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
