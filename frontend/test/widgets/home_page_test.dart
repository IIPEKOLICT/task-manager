import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/di/app.module.dart';
import 'package:frontend/widgets/pages/auth.page.dart';

import '../shared/utils.dart';

void main() async {
  await configureDependencies();
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('home page test', (WidgetTester tester) async {
    await tester.pumpWidget(createTestContainer(AuthPage.onCreate()));

    final iconFinder = find.byIcon(Icons.thumb_up_alt_sharp);
    final loginBtnFinder = find.text('Войти');
    final registerBtnFinder = find.text('Регистрация');
    final loaderFinder = find.byType(CircularProgressIndicator);

    expect(iconFinder, findsNothing);
    expect(loginBtnFinder, findsNothing);
    expect(registerBtnFinder, findsNothing);
    expect(loaderFinder, findsOneWidget);

    tester.runAsync(() async {
      await Future.delayed(const Duration(seconds: 1));

      expect(iconFinder, findsOneWidget);
      expect(loginBtnFinder, findsOneWidget);
      expect(registerBtnFinder, findsOneWidget);
      expect(loaderFinder, findsNothing);
    });
  });
}
