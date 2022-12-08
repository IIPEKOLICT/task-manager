import 'package:flutter/material.dart';
import 'package:frontend/models/comment.dart';
import 'package:frontend/view_models/comment.view_model.dart';
import 'package:frontend/widgets/cards/comment.card.dart';
import 'package:frontend/widgets/dialogs/comment.dialog.dart';
import 'package:provider/provider.dart';

import '../../../../di/app.module.dart';

class CommentListPage extends StatelessWidget {
  const CommentListPage({super.key});

  Future<void> Function() _showDialog(BuildContext context, {Comment? comment}) {
    return () async {
      final viewModel = context.read<CommentViewModel>();

      viewModel.setComment(comment);

      await showDialog(
        context: context,
        builder: (BuildContext ctx) => CommentDialog.onCreate(viewModel),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CommentViewModel>();

    return Scaffold(
      body: ListView(
        children: viewModel.isLoading
            ? const [LinearProgressIndicator()]
            : viewModel
                .getComments()
                .map(
                  (Comment comment) => CommentCard(
                    comment: comment,
                    onEdit: _showDialog(context, comment: comment),
                    onDelete: viewModel.deleteById(comment.id),
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
      create: (BuildContext context) => injector.get<CommentViewModel>(param1: context).create(),
      child: const CommentListPage(),
    );
  }
}
