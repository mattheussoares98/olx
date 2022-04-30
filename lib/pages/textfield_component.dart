import 'package:flutter/material.dart';

class TextFieldComponent extends StatefulWidget {
  final String label;
  final bool autoFocus;
  final TextInputType textInputType;
  final bool obscureText;
  final TextEditingController textEditingController;
  final bool isPassword;

  const TextFieldComponent({
    required this.label,
    required this.textEditingController,
    this.isPassword = false,
    this.autoFocus = false,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    Key? key,
  }) : super(key: key);

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      obscureText: widget.isPassword ? true : false,
      keyboardType: widget.textInputType,
      autofocus: widget.autoFocus,
      decoration: InputDecoration(
        labelText: widget.label,
        enabledBorder: _outlineInputBorder(),
        border: _outlineInputBorder(),
        focusedBorder: _outlineInputBorder(),
        disabledBorder: _outlineInputBorder(),
        errorBorder: _outlineInputBorder(),
        focusedErrorBorder: _outlineInputBorder(),
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
      validator: widget.isPassword
          ? (value) {
              if (value!.isEmpty) {
                return 'Digite a senha';
              } else if (value.length < 6) {
                return 'A senha deve conter no mínimo 6 caracteres';
              } else {
                return null;
              }
            }
          : (value) {
              if (value!.isEmpty) {
                return 'Digite o e-mail';
              } else if (!value.contains('@')) {
                return 'E-mail inválido';
              } else if (!value.contains('.')) {
                return 'E-mail inválido';
              } else {
                return null;
              }
            },
    );
  }
}
