import 'package:flutter/material.dart';

class ExceptionSnackbar extends SnackBar {
  final String message;

  ExceptionSnackbar(this.message, {super.key}) : super(
    backgroundColor: Colors.deepOrange,
    content: Text(message, style: const TextStyle(color: Colors.white)),
    action: SnackBarAction(
      label: 'Скрыть',
      textColor: Colors.black54,
      onPressed: () {}
    )
  );

  static void show(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(ExceptionSnackbar(message));
  }
}