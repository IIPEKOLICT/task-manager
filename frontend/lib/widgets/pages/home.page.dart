import 'package:flutter/material.dart';
import 'package:frontend/widgets/bottom_bar_page.dart';
import 'package:frontend/widgets/pages/project.page.dart';

import '../../data/bottom_bar.data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomBarPage(items: _tabItems);
  }

  static final List<BottomBarData> _tabItems = [
    BottomBarData('Проекты', Colors.lightBlue, const Icon(Icons.folder), ProjectPage.onCreate()),
    BottomBarData('Статистика', Colors.lightGreen, Icon(Icons.query_stats), Text('1')),
    BottomBarData('Аккаунт', Colors.limeAccent, Icon(Icons.account_circle), Text('3'))
  ];
}