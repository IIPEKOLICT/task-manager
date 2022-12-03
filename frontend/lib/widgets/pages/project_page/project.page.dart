import 'package:flutter/material.dart';
import 'package:frontend/widgets/bottom_bar_page.dart';
import 'package:frontend/widgets/pages/project_page/sub_pages/tag_list.page.dart';

import '../../../data/bottom_bar.data.dart';

class ProjectPage extends StatelessWidget {
  final String? _id;
  final bool _canEdit;

  const ProjectPage(this._id, this._canEdit, {super.key});

  @override
  Widget build(BuildContext context) {
    return BottomBarPage(
      items: _canEdit
          ? [
              ..._getPublicTabItems(),
              BottomBarData(
                'Теги',
                Colors.limeAccent,
                const Icon(Icons.tag),
                TagListPage.onCreate(_id ?? ''),
              ),
            ]
          : _getPublicTabItems(),
    );
  }

  static List<BottomBarData> _getPublicTabItems() {
    return [
      BottomBarData('Задачи', Colors.lightBlue, const Icon(Icons.task), Text('Нет контента')),
      BottomBarData('Статистика', Colors.lightGreen, const Icon(Icons.query_stats), Text('Нет контента')),
    ];
  }
}
