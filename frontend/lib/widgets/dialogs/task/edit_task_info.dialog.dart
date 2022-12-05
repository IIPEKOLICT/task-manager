import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:frontend/view_models/task.view_model.dart';
import 'package:provider/provider.dart';

import '../../components/text.input.dart';

class EditTaskInfoDialog extends StatelessWidget {
  final BuildContext _parentContext;

  const EditTaskInfoDialog(this._parentContext, {super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = _parentContext.watch<TaskViewModel>();

    return AlertDialog(
      scrollable: true,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.all(10),
      title: const Center(
        child: Text('Изменить задачу'),
      ),
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextInput(
              onInput: viewModel.setTitle,
              value: viewModel.getTitle(),
              hintText: 'Название',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextInput(
              onInput: viewModel.setDescription,
              value: viewModel.getDescription(),
              hintText: 'Описание',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextFormField(
              initialValue: viewModel.getExpectedHoursOrNull()?.toString(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Время выполнения (ч)',
                labelText: 'Время выполнения (ч)',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [services.FilteringTextInputFormatter.digitsOnly], // Only numbers
              onChanged: viewModel.setExpectedHours, // can be entered
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
          onPressed: !viewModel.isInfoValid ? null : viewModel.updateInfoHandler,
          child: const Text('Применить'),
        ),
      ],
    );
  }

  static Widget withContext(BuildContext context) {
    return EditTaskInfoDialog(context);
  }
}
