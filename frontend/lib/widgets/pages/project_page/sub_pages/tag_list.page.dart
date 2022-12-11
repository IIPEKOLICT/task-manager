import 'package:flutter/material.dart';
import 'package:frontend/models/tag.dart';
import 'package:frontend/view_models/tag.view_model.dart';
import 'package:frontend/widgets/cards/tag.card.dart';
import 'package:frontend/widgets/dialogs/tag.dialog.dart';
import 'package:provider/provider.dart';

import '../../../../di/app.module.dart';

class TagListPage extends StatelessWidget {
  const TagListPage({super.key});

  Future<void> Function() _showDialog(BuildContext context, {Tag? tag}) {
    return () async {
      final viewModel = context.read<TagViewModel>();

      viewModel.setTag(tag);

      await showDialog(
        context: context,
        builder: (BuildContext ctx) => TagDialog.onCreate(viewModel),
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
                    onEdit: _showDialog(context, tag: tag),
                    onDelete: viewModel.deleteById(tag.id),
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
      create: (BuildContext context) => injector.get<TagViewModel>(param1: context).create(),
      child: const TagListPage(),
    );
  }
}
