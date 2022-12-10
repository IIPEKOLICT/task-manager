import 'package:flutter/material.dart';

class SuccessSnackbar extends SnackBar {
  final String message;

  SuccessSnackbar(this.message, {super.key})
      : super(
          backgroundColor: Colors.green,
          content: Text(message, style: const TextStyle(color: Colors.white)),
          action: SnackBarAction(
            label: 'ОК',
            textColor: Colors.black54,
            onPressed: () {},
          ),
        );

  static void show(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SuccessSnackbar(message));
  }
}
