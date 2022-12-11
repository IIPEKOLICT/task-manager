import 'package:flutter/material.dart';
import 'package:frontend/widgets/components/list.component.dart';
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
      final viewModel = context.read<ProjectViewModel>();

      viewModel.setProject(project);

      showDialog(
        context: context,
        builder: (BuildContext ctx) => ProjectDialog.onCreate(viewModel),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProjectViewModel>();

    return ListComponent(
      isLoading: viewModel.isLoading,
      items: viewModel
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
      placeholder: 'Нет проектов',
      onAdd: _showProjectDialog(context),
    );
  }

  static Widget onCreate() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<ProjectViewModel>(param1: context).create(),
      child: const ProjectListPage(),
    );
  }
}
