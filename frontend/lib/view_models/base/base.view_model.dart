import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/dtos/response/exception.dto.dart';

import '../../widgets/components/exception.snackbar.dart';

abstract class BaseViewModel extends ChangeNotifier {
  @protected
  final BuildContext context;

  BaseViewModel(this.context);

  ExceptionDto? _parseExceptionResponse(e) {
    if (e.runtimeType != DioError || e.response?.data == null) {
      return null;
    }

    return ExceptionDto.fromJSON(e.response.data);
  }

  @protected
  void onException(exception, {String message = 'Неизвестная ошибка'}) {
    ExceptionDto? exceptionDto = _parseExceptionResponse(exception);
    String? backendMessage = exceptionDto != null
        ? '${exceptionDto.code}: ${exceptionDto.message ?? 'Неизвестная ошибка'}'
        : null;

    ExceptionSnackbar.show(backendMessage ?? message, context);
  }
}