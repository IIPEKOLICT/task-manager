import 'package:flutter/material.dart';
import 'package:frontend/models/note.dart';
import 'package:frontend/widgets/cards/note.card.dart';
import 'package:frontend/widgets/dialogs/note.dialog.dart';
import 'package:provider/provider.dart';

import '../../../../di/app.module.dart';
import '../../../../view_models/note.view_model.dart';

class NoteListPage extends StatelessWidget {
  const NoteListPage({super.key});

  Future<void> Function() _showDialog(BuildContext context, {Note? note}) {
    return () async {
      final viewModel = context.read<NoteViewModel>();

      viewModel.setNote(note);

      await showDialog(
        context: context,
        builder: (BuildContext ctx) => NoteDialog.onCreate(viewModel),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NoteViewModel>();

    return Scaffold(
      body: ListView(
        children: viewModel.isLoading
            ? const [LinearProgressIndicator()]
            : viewModel
                .getNotes()
                .map(
                  (Note note) => NoteCard(
                    note: note,
                    onEdit: _showDialog(context, note: note),
                    onDelete: viewModel.deleteById(note.id),
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
      create: (BuildContext context) => injector.get<NoteViewModel>(param1: context).create(),
      child: const NoteListPage(),
    );
  }
}
