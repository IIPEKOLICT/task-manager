import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final bool isPassword;
  final bool autofocus;
  final String? hintText;
  final Function(String)? onInput;

  const TextInput({
    super.key,
    this.isPassword = false,
    this.autofocus = false,
    this.hintText,
    this.onInput,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autofocus,
      onChanged: onInput,
      obscureText: isPassword,
      enableSuggestions: !isPassword,
      autocorrect: false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
}