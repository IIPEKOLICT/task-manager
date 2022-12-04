import 'package:flutter/material.dart';
import 'package:frontend/widgets/dialogs/project.dialog.dart';
import 'package:provider/provider.dart';

import '../../../../di/app.module.dart';
import '../../../../models/project.dart';
import '../../../../view_models/project.view_model.dart';
import '../../../cards/project.card.dart';

class ProjectListPage extends StatelessWidget {
  const ProjectListPage({super.key});

  Null Function() _showProjectDialog(BuildContext context, {Project? project}) {
    return () {
      showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return ProjectDialog.onCreate(project: project);
        },
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProjectViewModel>();

    return Scaffold(
      body: ListView(
        children: viewModel.isLoading
            ? const [LinearProgressIndicator()]
            : viewModel
                .getProjects()
                .map(
                  (Project project) => ProjectCard(
                    project: project,
                    onTap: viewModel.pickProjectHandler(project),
                    onEdit: _showProjectDialog(context, project: project),
                    onDelete: viewModel.deleteById(project.id),
                  ),
                )
                .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showProjectDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  static Widget onCreate() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<ProjectViewModel>(param1: context),
      child: const ProjectListPage(),
    );
  }
}
