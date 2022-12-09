import 'package:flutter/material.dart';
import 'package:frontend/models/attachment.dart';

class AttachmentCard extends StatelessWidget {
  final Attachment attachment;
  final VoidCallback? onCopy;
  final VoidCallback? onDownload;
  final VoidCallback? onDelete;

  const AttachmentCard({
    super.key,
    required this.attachment,
    this.onCopy,
    this.onDownload,
    this.onDelete,
  });

  List<Widget> get _buttons {
    final List<Widget> list = [
      TextButton(
        onPressed: onCopy,
        child: const Icon(
          Icons.copy,
          color: Colors.blue,
        ),
      ),
      TextButton(
        onPressed: onDownload,
        child: const Icon(
          Icons.download,
          color: Colors.green,
        ),
      ),
    ];

    if (attachment.canEdit) {
      list.add(
        TextButton(
          onPressed: onDelete,
          child: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      );
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        child: ListTile(
          leading: Icon(attachment.type.icon),
          title: Text(attachment.name),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: _buttons,
          ),
        ),
      ),
    );
  }
}
