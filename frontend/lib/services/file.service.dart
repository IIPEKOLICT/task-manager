import 'dart:io';

abstract class FileService {
  Future<File?> pickImage();
  Future<File?> pickFile();
  Future<bool> saveFile(String name, String url);
}
