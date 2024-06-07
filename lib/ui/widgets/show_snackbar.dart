import 'package:flutter/material.dart';

showSnackBar({required BuildContext context, required String text, Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: color ?? Theme.of(context).snackBarTheme.backgroundColor,
      duration: const Duration(milliseconds: 400),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),
  );
}
