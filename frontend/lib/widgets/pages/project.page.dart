import 'package:flutter/material.dart';
import 'package:frontend/widgets/dialogs/project.dialog.dart';
import 'package:provider/provider.dart';

import '../../di/app.module.dart';
import '../../models/project.dart';
import '../../view_models/project.view_model.dart';
import '../cards/project.card.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  Null Function() _showProjectDialog(BuildContext context, bool isEdit, {Project? project}) {
    return () {
      showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return ProjectDialog.onCreate(isEdit, project: project);
        },
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    final projectViewModel = context.watch<ProjectViewModel>();

    return Scaffold(
      body: ListView(
        children: projectViewModel.isLoading
            ? const [LinearProgressIndicator()]
            : projectViewModel
                .getProjects()
                .map(
                  (Project project) => ProjectCard(
                    project: project,
                    onEdit: _showProjectDialog(context, true, project: project),
                    onDelete: projectViewModel.deleteById(project.id),
                  ),
                )
                .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showProjectDialog(context, false),
        child: const Icon(Icons.add),
      ),
    );
  }

  static Widget onCreate() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<ProjectViewModel>(param1: context),
      child: const ProjectPage(),
    );
  }
}
