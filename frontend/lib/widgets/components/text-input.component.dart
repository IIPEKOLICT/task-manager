import 'package:flutter/material.dart';

class TextInputComponent extends StatelessWidget {
  final bool isPassword;
  final bool autofocus;
  final String? hintText;
  final Function(String)? onInput;
  final String value;

  final _controller = TextEditingController();

  TextInputComponent({
    super.key,
    this.isPassword = false,
    this.autofocus = false,
    this.hintText,
    this.onInput,
    this.value = '',
  });

  void setValue(String value) {
    _controller.text = value;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      onChanged: onInput,
      initialValue: value,
      obscureText: isPassword,
      enableSuggestions: !isPassword,
      autocorrect: false,
      // controller: _controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        labelText: hintText,
      ),
    );
  }
}
