import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class SaveFileService {
  static const int _requestTimeout = 30000;

  @protected
  Dio httpClient = Dio(BaseOptions(receiveTimeout: _requestTimeout));

  Future<bool> saveFile(String name, String url);
}
