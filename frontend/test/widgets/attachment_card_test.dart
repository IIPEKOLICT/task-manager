import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/di/app.module.dart';
import 'package:frontend/enums/file_type.enum.dart';
import 'package:frontend/models/attachment.dart';
import 'package:frontend/widgets/cards/attachment.card.dart';

import '../shared/utils.dart';

void main() async {
  await configureDependencies();
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('attachment card test', (WidgetTester tester) async {
    final attachment = Attachment(
      type: FileTypeEnum.image,
      name: 'attachment',
      canEdit: true,
    );

    await tester.pumpWidget(createTestContainer(AttachmentCard(attachment: attachment)));

    final nameFinder = find.text('attachment');
    final iconFinder = find.byIcon(FileTypeEnum.image.icon);
    final copyLinkBtnFinder = find.byIcon(Icons.copy);
    final downloadBtnFinder = find.byIcon(Icons.download);
    final deleteBtnFinder = find.byIcon(Icons.delete);

    expect(nameFinder, findsOneWidget);
    expect(iconFinder, findsOneWidget);
    expect(copyLinkBtnFinder, findsOneWidget);
    expect(downloadBtnFinder, findsOneWidget);
    expect(deleteBtnFinder, findsOneWidget);

    attachment.canEdit = false;

    await tester.pumpWidget(createTestContainer(AttachmentCard(attachment: attachment)));

    expect(nameFinder, findsOneWidget);
    expect(iconFinder, findsOneWidget);
    expect(copyLinkBtnFinder, findsOneWidget);
    expect(downloadBtnFinder, findsOneWidget);
    expect(deleteBtnFinder, findsNothing);

    attachment.name = 'changed name';

    await tester.pumpWidget(createTestContainer(AttachmentCard(attachment: attachment)));

    final changedNameFinder = find.text('changed name');

    expect(nameFinder, findsNothing);
    expect(changedNameFinder, findsOneWidget);

    attachment.type = FileTypeEnum.application;

    await tester.pumpWidget(createTestContainer(AttachmentCard(attachment: attachment)));

    final changedIconFinder = find.byIcon(FileTypeEnum.application.icon);

    expect(iconFinder, findsNothing);
    expect(changedIconFinder, findsOneWidget);
  });
}
