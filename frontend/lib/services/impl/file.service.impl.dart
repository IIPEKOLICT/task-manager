import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:frontend/services/file.service.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@LazySingleton(as: FileService)
class FileServiceImpl extends FileService {
  static final Dio downloadClient = Dio();

  @override
  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
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

  @override
  Future<bool> saveFile(String name, String url) async {
    if (Platform.isAndroid) {
      final PermissionStatus status = await Permission.storage.request();

      if (status.isDenied) {
        return false;
      }

      final directory = Directory('/storage/emulated/0/Download');
      final String filePath = '${directory.path}/$name';

      await File(filePath).writeAsString('');
      await Dio().download(url, filePath);
      return true;
    }

    final String? filePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Выберите расположение',
      fileName: name,
    );

    if (filePath != null) {
      await Dio().download(url, filePath);
      return true;
    }

    return false;
  }
}
