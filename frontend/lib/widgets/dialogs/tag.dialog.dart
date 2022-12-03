import 'package:flutter/material.dart';
import 'package:frontend/view_models/dialog/tag_dialog.view_model.dart';
import 'package:provider/provider.dart';

import '../../di/app.module.dart';
import '../../models/tag.dart';
import '../components/text.input.dart';

class TagDialog extends StatelessWidget {
  final bool _isEdit;
  final Tag? _tag;

  const TagDialog(this._isEdit, this._tag, {super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TagDialogViewModel>();

    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.all(10),
      title: Center(
        child: Text('${_isEdit ? 'Изменение' : 'Создание'} тега'),
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
          onPressed: !viewModel.isValid ? null : viewModel.submitHandler(_isEdit),
          child: Text(_isEdit ? 'Изменить' : 'Создать'),
        ),
      ],
    );
  }

  static Widget onCreate(bool isEdit, {Tag? tag}) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<TagDialogViewModel>(param1: context, param2: tag),
      child: TagDialog(isEdit, tag),
    );
  }
}
