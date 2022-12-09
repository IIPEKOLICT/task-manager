import 'package:flutter/material.dart';
import 'package:frontend/enums/route.enum.dart';
import 'package:frontend/widgets/bottom_bar_page.dart';
import 'package:frontend/widgets/pages/project_page/sub_pages/tag_list.page.dart';
import 'package:frontend/widgets/pages/project_page/sub_pages/task_list.page.dart';
import 'package:go_router/go_router.dart';

import '../../../data/bottom_bar.data.dart';

class ProjectPage extends StatelessWidget {
  final bool _canEdit;

  const ProjectPage(this._canEdit, {super.key});

  @override
  Widget build(BuildContext context) {
    return BottomBarPage(
      onBack: () => context.go(RouteEnum.home.value),
      items: _canEdit
          ? [
              ..._publicBarItems,
              BottomBarData(
                'Теги',
                Colors.limeAccent,
                const Icon(Icons.tag),
                TagListPage.onCreate(),
              ),
            ]
          : _publicBarItems,
    );
  }

  static final List<BottomBarData> _publicBarItems = [
    BottomBarData(
      'Задачи',
      Colors.blueAccent,
      const Icon(Icons.task),
      TaskListPage.onCreate(),
    ),
    BottomBarData(
      'График',
      Colors.greenAccent,
      const Icon(Icons.query_stats),
      Text('Нет контента'),
    ),
  ];
}
