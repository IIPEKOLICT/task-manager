import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final String title;
  final void Function()? onTap;

  const ButtonComponent({super.key, this.title = '', this.onTap});

  static final ButtonStyle _btnStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(10),
    minimumSize: const Size(40, 40),
    textStyle: const TextStyle(fontSize: 20),
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: _btnStyle,
      onPressed: onTap,
      child: Text(title),
    );
  }
}
