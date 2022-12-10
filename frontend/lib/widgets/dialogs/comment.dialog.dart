import 'package:flutter/material.dart';
import 'package:frontend/view_models/comment.view_model.dart';
import 'package:provider/provider.dart';

import '../components/text_input.component.dart';

class CommentDialog extends StatelessWidget {
  const CommentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CommentViewModel>();

    return AlertDialog(
      scrollable: true,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.all(10),
      title: Center(
        child: Text('${viewModel.isEdit ? 'Изменение' : 'Создание'} комментария'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextInputComponent(
              onInput: viewModel.setText,
              hintText: 'Текст',
              value: viewModel.getText(),
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

  static Widget onCreate(CommentViewModel viewModel) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => viewModel.copy(context),
      child: const CommentDialog(),
    );
  }
}
