import 'package:flutter/material.dart';
import 'package:frontend/view_models/tag.view_model.dart';
import 'package:provider/provider.dart';

import '../components/text_input.component.dart';

class TagDialog extends StatelessWidget {
  const TagDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TagViewModel>();

    return AlertDialog(
      scrollable: true,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.all(10),
      title: Center(
        child: Text('${viewModel.isEdit ? 'Изменение' : 'Создание'} тега'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextInputComponent(
              onInput: viewModel.setName,
              hintText: 'Название',
              value: viewModel.getName(),
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
          onPressed: !viewModel.isValid ? null : viewModel.submitHandler,
          child: Text(viewModel.isEdit ? 'Изменить' : 'Создать'),
        ),
      ],
    );
  }

  static Widget onCreate(TagViewModel viewModel) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => viewModel.copy(context),
      child: const TagDialog(),
    );
  }
}
