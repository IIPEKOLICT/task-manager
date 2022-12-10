import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

import '../save_file.service.dart';

@LazySingleton()
class DesktopSaveFileServiceImpl extends SaveFileService {
  @override
  Future<bool> saveFile(String name, String url) async {
    final String? filePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Выберите расположение',
      fileName: name,
    );

    if (filePath != null) {
      await httpClient.download(url, filePath);
      return true;
    }

    return false;
  }
}
