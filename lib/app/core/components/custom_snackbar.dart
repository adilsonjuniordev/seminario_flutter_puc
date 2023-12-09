import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomSnackbar {
  final BuildContext context;
  final String message;
  final Color backgroundColor;
  final Duration? duration;

  CustomSnackbar.success({
    required this.context,
    required this.message,
    this.backgroundColor = Colors.lightGreen,
    this.duration,
  }) {
    showSnackBar(context: context, message: message, color: backgroundColor);
  }

  CustomSnackbar.error({
    required this.context,
    required this.message,
    this.backgroundColor = Colors.red,
    this.duration,
  }) {
    showSnackBar(context: context, message: message, color: backgroundColor);
  }

  CustomSnackbar.warning({
    required this.context,
    required this.message,
    this.backgroundColor = Colors.blueGrey,
    this.duration,
  }) {
    showSnackBar(context: context, message: message, color: backgroundColor);
  }

  static void showSnackBar({
    required BuildContext context,
    required String message,
    required Color color,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? 2.seconds,
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
