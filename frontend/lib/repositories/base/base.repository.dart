import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/app.module.dart';

abstract class BaseRepository {
  final Dio httpClient;
  final Future<SharedPreferences> sharedPreferences = injector.getAsync();

  abstract final String endpoint;

  BaseRepository(this.httpClient);

  _getHeaders() async {
    return { 'Authorization': 'Bearer ${(await sharedPreferences).get('TOKEN') ?? ''}' };
  }

  String _getUri(String path) {
    return endpoint.isEmpty ? path : '$endpoint/$path';
  }

  Future<T> _sendRequest<T>(String method, {String path = '', dynamic body = const Object()}) async {
    Response<dynamic> response = await httpClient.request(
        _getUri(path),
        data: body,
        options: Options(headers: _getHeaders(), method: method)
    );

    return jsonDecode(response.data) as T;
  }

  Future<T> get<T>({String path = ''}) async {
    return _sendRequest('GET', path: path);
  }

  Future<T> post<T>({String path = '', dynamic body = const Object()}) async {
    return _sendRequest('POST', path: path, body: body);
  }

  Future<T> patch<T>({String path = '', dynamic body = const Object()}) async {
    return _sendRequest('PATCH', path: path, body: body);
  }

  Future<T> put<T>({String path = '', dynamic body = const Object()}) async {
    return _sendRequest('PUT', path: path, body: body);
  }

  Future<T> delete<T>({String path = '', dynamic body = const Object()}) async {
    return _sendRequest('DELETE', path: path, body: body);
  }
}