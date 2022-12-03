import 'package:flutter/material.dart';
import 'package:frontend/models/tag.dart';
import 'package:frontend/view_models/tag.view_model.dart';
import 'package:frontend/widgets/cards/tag.card.dart';
import 'package:frontend/widgets/dialogs/tag.dialog.dart';
import 'package:provider/provider.dart';

import '../../../../di/app.module.dart';

class TagListPage extends StatelessWidget {
  const TagListPage({super.key});

  Future<void> Function() _showDialog(BuildContext context, bool isEdit, {Tag? tag}) {
    return () async {
      await showDialog(
        context: context,
        builder: (BuildContext ctx) => TagDialog.onCreate(isEdit, tag: tag),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TagViewModel>();

    return Scaffold(
      body: ListView(
        children: viewModel.isLoading
            ? const [LinearProgressIndicator()]
            : viewModel
                .getTags()
                .map(
                  (Tag tag) => TagCard(
                    tag: tag,
                    onEdit: viewModel.isProjectLoaded ? _showDialog(context, true, tag: tag) : null,
                    onDelete: viewModel.isProjectLoaded ? viewModel.deleteById(tag.id) : null,
                  ),
                )
                .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.isProjectLoaded ? _showDialog(context, false) : null,
        child: const Icon(Icons.add),
      ),
    );
  }

  static Widget onCreate(String projectId) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<TagViewModel>(param1: context, param2: projectId),
      child: const TagListPage(),
    );
  }
}
