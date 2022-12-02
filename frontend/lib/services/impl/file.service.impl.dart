import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:frontend/services/file.service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FileService)
class FileServiceImpl extends FileService {
  @override
  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
    );

    if (result == null) return null;
    return File(result.files.single.path ?? (throw Exception()));
  }

  @override
  Future<File?> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result == null) return null;
    return File(result.files.single.path ?? (throw Exception()));
  }
}
