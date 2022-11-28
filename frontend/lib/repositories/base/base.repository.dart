import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/storage.service.dart';

abstract class BaseRepository {
  @protected
  final Dio httpClient;

  @protected
  final StorageService storageService;

  @protected
  abstract final String endpoint;

  BaseRepository(this.httpClient, this.storageService);

  _getHeaders() async {
    return { 'Authorization': 'Bearer ${await storageService.getToken() ?? ''}' };
  }

  String _getUri(String path) {
    return endpoint.isEmpty ? '/$path' : '/$endpoint/$path';
  }

  Future<T> _sendRequest<T>(String method, {String path = '', dynamic body = const Object()}) async {
    Response<T> response = await httpClient.request(
      _getUri(path),
      data: body,
      options: Options(headers: await _getHeaders(), method: method)
    );

    return response.data ?? Object() as T;
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