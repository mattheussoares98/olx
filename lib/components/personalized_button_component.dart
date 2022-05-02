import 'package:flutter/material.dart';

class PersonalizedButtonComponent extends StatelessWidget {
  final Color textColor;
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  const PersonalizedButtonComponent({
    Key? key,
    required this.onPressed,
    required this.text,
    this.textColor = Colors.white,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          maximumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          )),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(
              text,
              style: TextStyle(
                color: textColor,
              ),
            ),
    );
  }
}
