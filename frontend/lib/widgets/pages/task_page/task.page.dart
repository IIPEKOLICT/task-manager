import 'package:flutter/material.dart';
import 'package:frontend/widgets/bottom_bar_page.dart';
import 'package:frontend/widgets/pages/task_page/sub_pages/attachment_list.page.dart';
import 'package:frontend/widgets/pages/task_page/sub_pages/comment_list.page.dart';
import 'package:frontend/widgets/pages/task_page/sub_pages/note_list.page.dart';
import 'package:frontend/widgets/pages/task_page/sub_pages/task_info.page.dart';
import 'package:frontend/widgets/pages/task_page/sub_pages/work_list.page.dart';
import 'package:go_router/go_router.dart';

import '../../../data/bottom_bar.data.dart';
import '../../../enums/route.enum.dart';

class TaskPage extends StatelessWidget {
  final bool _isOwnerOfProject;

  const TaskPage(this._isOwnerOfProject, {super.key});

  @override
  Widget build(BuildContext context) {
    return BottomBarPage(
      onBack: () => context.go('${RouteEnum.project.value}?canEdit=$_isOwnerOfProject'),
      items: _barItems,
    );
  }

  static final List<BottomBarData> _barItems = [
    BottomBarData(
      'Инфо',
      Colors.redAccent.withOpacity(_itemOpacity),
      const Icon(Icons.info),
      TaskInfoPage.onCreate(),
    ),
    BottomBarData(
      'Заметки',
      Colors.yellowAccent.withOpacity(_itemOpacity),
      const Icon(Icons.note),
      NoteListPage.onCreate(),
    ),
    BottomBarData(
      'Комментарии',
      Colors.greenAccent.withOpacity(_itemOpacity),
      const Icon(Icons.comment),
      CommentListPage.onCreate(),
    ),
    BottomBarData(
      'Вложения',
      Colors.blueAccent.withOpacity(_itemOpacity),
      const Icon(Icons.attachment),
      AttachmentListPage.onCreate(),
    ),
    BottomBarData(
      'Время',
      Colors.deepPurpleAccent.withOpacity(_itemOpacity),
      const Icon(Icons.timer),
      WorkListPage.onCreate(),
    ),
  ];

  static const double _itemOpacity = 0.2;
}
