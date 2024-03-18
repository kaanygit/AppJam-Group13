import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
    ),
  );
}

void showSuccessSnackBar(BuildContext context, String successMessage) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(successMessage),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.green,
  ));
}
