import 'package:flutter/material.dart';
import 'package:frontend/widgets/pages/login.page.dart';

import '../../constants/ui.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text(appHeader)),
        body: LoginPage.create(),
      )
    );
  }
}