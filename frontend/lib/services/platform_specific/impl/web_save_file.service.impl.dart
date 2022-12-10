import 'package:injectable/injectable.dart';
import 'package:universal_html/html.dart';

import '../save_file.service.dart';

@LazySingleton()
class WebSaveFileServiceImpl extends SaveFileService {
  @override
  Future<bool> saveFile(String name, String url) async {
    final anchorElement = AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
    return true;
  }
}
