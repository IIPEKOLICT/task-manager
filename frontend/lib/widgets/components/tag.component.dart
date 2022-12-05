import 'package:flutter/material.dart';

import '../../models/tag.dart';

class TagComponent extends StatelessWidget {
  final Tag _tag;

  const TagComponent(this._tag, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
      child: Chip(
        labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        label: Text(_tag.name),
        backgroundColor: _tag.color,
        elevation: 5,
        shadowColor: Colors.grey[60],
      ),
    );
  }
}
