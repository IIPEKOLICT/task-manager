import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

import '../save_file.service.dart';

@LazySingleton()
class MobileSaveFileServiceImpl extends SaveFileService {
  Future<String> _generateFilePath(Directory directory, String name) async {
    final List<String> fileNameArr = name.split('.');
    final String extension = fileNameArr.removeLast();
    final String originalFileName = fileNameArr.join('.');

    String fileName = originalFileName;
    int counter = 0;

    while (await File('${directory.path}/$fileName.$extension').exists()) {
      fileName = '$originalFileName (${++counter})';
    }

    return '${directory.path}/$fileName.$extension';
  }

  @override
  Future<bool> saveFile(String name, String url) async {
    final PermissionStatus status = await Permission.storage.request();

    if (status.isDenied) {
      return false;
    }

    final directory = Directory('/storage/emulated/0/Download');

    if (!(await directory.exists())) {
      throw Exception('Папка downloads не найдена');
    }

    final String filePath = await _generateFilePath(directory, name);
    final File file = await File(filePath).create();
    await httpClient.download(url, file.path);
    return true;
  }
}
