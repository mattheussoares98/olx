import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldComponent extends StatefulWidget {
  final String label;
  final bool autoFocus;
  final TextInputType textInputType;
  final bool obscureText;
  final TextEditingController textEditingController;
  final bool isPassword;
  final bool enabled;
  final List<TextInputFormatter>? textInputFormatter;
  final String? Function(String?)? validator;
  final int maxLength;
  final int maxLines;

  const TextFieldComponent({
    required this.label,
    required this.textEditingController,
    required this.enabled,
    this.validator,
    this.maxLength = 50,
    this.maxLines = 1,
    this.textInputFormatter,
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
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      inputFormatters: widget.textInputFormatter,
      controller: widget.textEditingController,
      obscureText: widget.isPassword ? true : false,
      keyboardType: widget.textInputType,
      autofocus: widget.autoFocus,
      enabled: widget.enabled,
      decoration: InputDecoration(
        counterText: '',
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
      validator: widget.validator,
    );
  }
}
