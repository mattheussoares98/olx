import 'package:flutter/material.dart';

class ShowDialogComponent {
  showDialogComponent({
    required BuildContext context,
    required List<Widget> widgets,
    String? title,
    String? subtitle,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          insetPadding: const EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 30,
          ),
          titlePadding: const EdgeInsets.all(20),
          buttonPadding: const EdgeInsets.all(1),
          actionsPadding: const EdgeInsets.all(0),
          title: title != null
              ? Text(
                  title,
                  textAlign: TextAlign.center,
                )
              : null,
          content: subtitle != null
              ? Text(
                  subtitle,
                  textAlign: TextAlign.center,
                )
              : null,
          actions: widgets,
        );
      },
    );
  }
}
