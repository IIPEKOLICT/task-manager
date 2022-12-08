import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/dtos/response/exception.dto.dart';

import '../../widgets/shackbars/exception.snackbar.dart';

abstract class BaseViewModel extends ChangeNotifier {
  @protected
  final BuildContext context;

  final int _internalStatusCode = 600;

  BaseViewModel(this.context) {
    onInit();
  }

  @protected
  void onInit() {}

  ExceptionDto? _parseExceptionResponse(e) {
    if (e is DioError && e.response?.data != null) {
      try {
        return ExceptionDto.fromJSON(e.response!.data);
      } catch (exc) {
        final String body = e.response!.data!.toString();
        if (body.isEmpty) return null;
        return ExceptionDto(_internalStatusCode, body);
      }
    }

    if (e is DioError) {
      return ExceptionDto(_internalStatusCode, e.message);
    }

    return null;
  }

  @protected
  void onException(exception, {String message = 'Неизвестная ошибка'}) {
    ExceptionDto? exceptionDto = _parseExceptionResponse(exception);

    if (exceptionDto == null) {
      ExceptionSnackbar.show(message, context);
      return;
    }

    if (exceptionDto.code == _internalStatusCode) {
      ExceptionSnackbar.show(exceptionDto.message ?? message, context);
      return;
    }

    ExceptionSnackbar.show('${exceptionDto.code}: ${exceptionDto.message ?? message}', context);
  }

  @protected
  void defaultSubscriber(_) => notifyListeners();
}
