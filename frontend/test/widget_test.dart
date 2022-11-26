import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/di/app.module.dart';
import 'package:frontend/widgets/app.dart';

void main() async {
  await configureDependencies();
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('home page test', (WidgetTester tester) async {
    await tester.pumpWidget(App());
  });
}
