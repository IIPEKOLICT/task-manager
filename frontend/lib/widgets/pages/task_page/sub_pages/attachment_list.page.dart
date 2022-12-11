import 'package:flutter/material.dart';
import 'package:frontend/view_models/attachment.view_model.dart';
import 'package:frontend/widgets/cards/attachment.card.dart';
import 'package:provider/provider.dart';

import '../../../../di/app.module.dart';
import '../../../../models/attachment.dart';
import '../../../components/list.component.dart';

class AttachmentListPage extends StatelessWidget {
  const AttachmentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AttachmentViewModel>();

    return ListComponent(
      isLoading: viewModel.isLoading,
      items: viewModel
          .getAttachments()
          .map(
            (Attachment attachment) => AttachmentCard(
              attachment: attachment,
              onCopy: viewModel.copyUrlHandler(attachment.url),
              onDownload: viewModel.downloadHandler(attachment),
              onDelete: viewModel.deleteById(attachment.id),
            ),
          )
          .toList(),
      placeholder: 'Нет вложений',
      onAdd: viewModel.createHandler,
    );
  }

  static Widget onCreate() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<AttachmentViewModel>(param1: context).create(),
      child: const AttachmentListPage(),
    );
  }
}
