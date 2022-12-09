import 'package:flutter/material.dart';
import 'package:frontend/view_models/work.view_model.dart';
import 'package:frontend/widgets/cards/work.card.dart';
import 'package:frontend/widgets/dialogs/work.dialog.dart';
import 'package:provider/provider.dart';

import '../../../../di/app.module.dart';
import '../../../../models/work.dart';

class WorkListPage extends StatelessWidget {
  const WorkListPage({super.key});

  Future<void> Function() _showDialog(BuildContext context, {Work? work}) {
    return () async {
      final viewModel = context.read<WorkViewModel>();

      viewModel.setWork(work);

      await showDialog(
        context: context,
        builder: (BuildContext ctx) => WorkDialog.onCreate(viewModel),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WorkViewModel>();

    return Scaffold(
      body: ListView(
        children: viewModel.isLoading
            ? const [LinearProgressIndicator()]
            : viewModel
                .getWorks()
                .map(
                  (Work work) => WorkCard(
                    work: work,
                    onEdit: _showDialog(context, work: work),
                    onDelete: viewModel.deleteById(work.id),
                  ),
                )
                .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  static Widget onCreate() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<WorkViewModel>(param1: context).create(),
      child: const WorkListPage(),
    );
  }
}
