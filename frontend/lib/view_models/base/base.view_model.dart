import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/dtos/response/exception.dto.dart';

import '../../widgets/components/exception.snackbar.dart';

abstract class BaseViewModel extends ChangeNotifier {
  @protected
  final BuildContext context;

  BaseViewModel(this.context);

  ExceptionDto? _parseExceptionResponse(e) {
    if (e is DioError && e.response?.data != null) {
      return ExceptionDto.fromJSON(e.response!.data);
    }

    if (e is DioError) {
      return ExceptionDto(HttpStatus.internalServerError, e.message);
    }

    return null;
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