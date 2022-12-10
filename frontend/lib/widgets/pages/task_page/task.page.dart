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
      _itemColor,
      const Icon(Icons.info),
      TaskInfoPage.onCreate(),
    ),
    BottomBarData(
      'Заметки',
      _itemColor,
      const Icon(Icons.note),
      NoteListPage.onCreate(),
    ),
    BottomBarData(
      'Комментарии',
      _itemColor,
      const Icon(Icons.comment),
      CommentListPage.onCreate(),
    ),
    BottomBarData(
      'Вложения',
      _itemColor,
      const Icon(Icons.attachment),
      AttachmentListPage.onCreate(),
    ),
    BottomBarData(
      'Время',
      _itemColor,
      const Icon(Icons.timer),
      WorkListPage.onCreate(),
    ),
  ];

  static final Color? _itemColor = Color.lerp(Colors.black, Colors.white, 0.1);
}
