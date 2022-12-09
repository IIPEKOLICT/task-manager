import 'package:flutter/material.dart';
import 'package:frontend/models/base/base_entity.dart';
import 'package:frontend/view_models/work.view_model.dart';
import 'package:provider/provider.dart';

import '../components/text_input.component.dart';

class WorkDialog extends StatelessWidget {
  const WorkDialog({super.key});

  String _showTime(DateTime? date) {
    if (date == null) return 'Не задано';
    return '${BaseEntity.renderDate(date)} (${BaseEntity.renderTime(date)})';
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WorkViewModel>();

    return AlertDialog(
      scrollable: true,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.all(10),
      title: Center(
        child: Text('${viewModel.isEdit ? 'Изменение' : 'Создание'} работы'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextInputComponent(
              onInput: viewModel.setDescription,
              hintText: 'Описание',
              value: viewModel.getDescription(),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: const Text('Начало'),
            subtitle: Text(_showTime(viewModel.getStartDate())),
            trailing: TextButton(
              onPressed: viewModel.pickStartTime,
              child: const Icon(Icons.edit),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: const Text('Конец'),
            subtitle: Text(_showTime(viewModel.getEndDate())),
            trailing: TextButton(
              onPressed: viewModel.pickEndTime,
              child: const Icon(Icons.edit),
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

  static Widget onCreate(WorkViewModel viewModel) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => viewModel.copy(context),
      child: const WorkDialog(),
    );
  }
}
