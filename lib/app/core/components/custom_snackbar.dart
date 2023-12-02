// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomSnackbar {
  final BuildContext context;
  final String message;
  final Color backgroundColor;

  CustomSnackbar.success({
    required this.context,
    required this.message,
    this.backgroundColor = Colors.lightGreen,
  }) {
    showSnackBar(context: context, message: message, color: backgroundColor);
  }

  CustomSnackbar.error({
    required this.context,
    required this.message,
    this.backgroundColor = Colors.red,
  }) {
    showSnackBar(context: context, message: message, color: backgroundColor);
  }

  static void showSnackBar({
    required BuildContext context,
    required String message,
    required Color color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {},
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}
