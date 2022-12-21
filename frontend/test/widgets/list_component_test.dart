import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/di/app.module.dart';
import 'package:frontend/widgets/components/list.component.dart';

import '../shared/utils.dart';

void main() async {
  await configureDependencies();
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('list component test', (WidgetTester tester) async {
    bool isAdded = false;

    final listComponent = ListComponent(
      isLoading: true,
      items: const [],
      placeholder: 'no items',
      onAdd: () => isAdded = true,
    );

    final listComponentLoaded = ListComponent(
      isLoading: false,
      items: const [],
      placeholder: 'no items',
      onAdd: () => isAdded = true,
    );

    await tester.pumpWidget(createTestContainer(listComponent));

    final placeholderFinder = find.text('no items');
    final addBtnFinder = find.byIcon(Icons.add);
    final loaderFinder = find.byType(LinearProgressIndicator);

    expect(placeholderFinder, findsNothing);
    expect(addBtnFinder, findsOneWidget);
    expect(loaderFinder, findsOneWidget);
    expect(isAdded, false);

    await tester.pumpWidget(createTestContainer(listComponentLoaded));

    expect(placeholderFinder, findsOneWidget);
    expect(addBtnFinder, findsOneWidget);
    expect(loaderFinder, findsNothing);
    expect(isAdded, false);

    await tester.tap(addBtnFinder);

    expect(placeholderFinder, findsOneWidget);
    expect(addBtnFinder, findsOneWidget);
    expect(loaderFinder, findsNothing);
    expect(isAdded, true);
  });
}
