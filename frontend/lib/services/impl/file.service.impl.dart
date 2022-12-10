import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/services/file.service.dart';
import 'package:frontend/services/platform_specific/impl/desktop_save_file.service.impl.dart';
import 'package:frontend/services/platform_specific/impl/mobile_save_file.service.impl.dart';
import 'package:frontend/services/platform_specific/save_file.service.dart';
import 'package:injectable/injectable.dart';

import '../../di/app.module.dart';
import '../platform_specific/impl/web_save_file.service.impl.dart';

@LazySingleton(as: FileService)
class FileServiceImpl extends FileService {
  SaveFileService get _saveFileService {
    if (kIsWeb) {
      return injector.get<WebSaveFileServiceImpl>();
    }

    if (Platform.isAndroid) {
      return injector.get<MobileSaveFileServiceImpl>();
    }

    if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      return injector.get<DesktopSaveFileServiceImpl>();
    }

    throw Exception('Данная платформа не поддерживается');
  }

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
    return _saveFileService.saveFile(name, url);
  }
}
