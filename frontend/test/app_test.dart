import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/constants/ui.dart';
import 'package:frontend/di/app.module.dart';
import 'package:frontend/widgets/app.dart';

import 'shared/utils.dart';

void main() async {
  await configureDependencies();
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('app test', (WidgetTester tester) async {
    await tester.pumpWidget(createTestContainer(App()));

    final appBarFinder = find.text(appName);

    expect(appBarFinder, findsOneWidget);
  });
}
