import 'dart:io';

abstract class FileService {
  Future<File?> pickImage();
  Future<File?> pickFile();
}
