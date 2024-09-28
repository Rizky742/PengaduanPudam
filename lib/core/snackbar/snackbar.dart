import 'package:flutter/material.dart';
import 'package:pengaduan/theme.dart';

snackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: pastelRed,
    content: Text(message),
  ));
}
