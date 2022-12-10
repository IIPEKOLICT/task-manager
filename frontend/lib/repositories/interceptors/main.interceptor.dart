import 'dart:io';

import 'package:dio/dio.dart';
import 'package:frontend/services/storage.service.dart';
import 'package:frontend/view_models/state/auth.state.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class MainInterceptor extends Interceptor {
  final AuthState _authState;
  final StorageService _storageService;

  MainInterceptor(this._authState, this._storageService);

  Future<String?> _grabToken() async {
    return _authState.getTokenOrNull() ?? (await _storageService.getTokenOrNull());
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _grabToken().then((String? token) {
      options.headers[HttpHeaders.authorizationHeader] = token != null ? 'Bearer $token' : '';
      handler.next(options);
    });
  }
}
