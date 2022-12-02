import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/view_models/state/auth.state.dart';

abstract class BaseRepository {
  @protected
  final Dio httpClient;

  @protected
  final AuthState authState;

  @protected
  abstract final String endpoint;

  BaseRepository(this.httpClient, this.authState);

  get _headers {
    return {
      HttpHeaders.authorizationHeader: 'Bearer ${authState.getToken() ?? ''}',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
  }

  String _getUri(String path) {
    if (path.isEmpty) return endpoint.isEmpty ? '' : '/$endpoint';
    return endpoint.isEmpty ? '/$path' : '/$endpoint/$path';
  }

  Future<T> _sendRequest<T>(String method, {String path = '', dynamic body}) async {
    Response<T> response = await httpClient.request(
      _getUri(path),
      data: body,
      options: Options(
        headers: _headers,
        method: method,
      ),
    );

    return (response.data ?? Object()) as T;
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

  Future<T> delete<T>({String path = ''}) async {
    return _sendRequest('DELETE', path: path);
  }
}
