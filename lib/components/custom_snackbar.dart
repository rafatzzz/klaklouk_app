import 'package:flutter/material.dart';

void CustomSnackbar({
  required BuildContext context,
  required String message,
  IconData? icon,
  Color backgroundColor = Colors.green,
  Duration duration = const Duration(seconds: 3),
  double borderRadius = 8.0,
}) {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: backgroundColor,
    duration: duration,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    margin: EdgeInsets.all(10), // Adds spacing from screen edges
    content: Row(
      children: [
        if (icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(icon, color: Colors.white),
          ),
        Expanded(
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
    action: SnackBarAction(
      label: 'Dismiss',
      textColor: Colors.white,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}