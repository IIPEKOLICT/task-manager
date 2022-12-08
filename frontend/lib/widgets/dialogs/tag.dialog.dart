import 'package:flutter/material.dart';
import 'package:frontend/view_models/tag.view_model.dart';
import 'package:provider/provider.dart';

import '../../models/tag.dart';
import '../components/text.input.dart';

class TagDialog extends StatelessWidget {
  final Tag? _tag;

  const TagDialog(this._tag, {super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TagViewModel>();
    final isEdit = _tag != null;

    return AlertDialog(
      scrollable: true,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.all(10),
      title: Center(
        child: Text('${isEdit ? 'Изменение' : 'Создание'} тега'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextInput(
              onInput: viewModel.setName,
              hintText: 'Название',
              value: _tag?.name ?? '',
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Закрыть'),
        ),
        ElevatedButton(
          onPressed: !viewModel.isValid ? null : viewModel.submitHandler(isEdit),
          child: Text(isEdit ? 'Изменить' : 'Создать'),
        ),
      ],
    );
  }

  static Widget onCreate(Tag? tag, TagViewModel viewModel) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => viewModel.copy(context),
      child: TagDialog(tag),
    );
  }
}
