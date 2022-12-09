import 'dart:io';

abstract class FileService {
  Future<File?> pickImage();
  Future<File?> pickFile();
  Future<void> saveFile(String name, String url);
}
