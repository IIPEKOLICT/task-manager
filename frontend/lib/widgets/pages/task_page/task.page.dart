import 'package:flutter/material.dart';
import 'package:frontend/enums/route.enum.dart';
import 'package:frontend/widgets/bottom_bar_page.dart';
import 'package:frontend/widgets/pages/task_page/sub_pages/attachment_list.page.dart';
import 'package:frontend/widgets/pages/task_page/sub_pages/comment_list.page.dart';
import 'package:frontend/widgets/pages/task_page/sub_pages/note_list.page.dart';
import 'package:frontend/widgets/pages/task_page/sub_pages/task_info.page.dart';
import 'package:frontend/widgets/pages/task_page/sub_pages/work_list.page.dart';
import 'package:go_router/go_router.dart';

import '../../../data/bottom_bar.data.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomBarPage(
      onBack: () => context.go(RouteEnum.project.value),
      items: _barItems,
    );
  }

  static final List<BottomBarData> _barItems = [
    BottomBarData(
      'Инфо',
      Colors.redAccent,
      const Icon(Icons.info),
      TaskInfoPage.onCreate(),
    ),
    BottomBarData(
      'Заметки',
      Colors.yellowAccent,
      const Icon(Icons.note),
      NoteListPage.onCreate(),
    ),
    BottomBarData(
      'Комментарии',
      Colors.greenAccent,
      const Icon(Icons.comment),
      CommentListPage.onCreate(),
    ),
    BottomBarData(
      'Вложения',
      Colors.blueAccent,
      const Icon(Icons.attachment),
      AttachmentListPage.onCreate(),
    ),
    BottomBarData(
      'Время',
      Colors.deepPurpleAccent,
      const Icon(Icons.timer),
      WorkListPage.onCreate(),
    ),
  ];
}
