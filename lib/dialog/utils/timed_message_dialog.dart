import 'package:flutter/material.dart';

/// Renders a dialog box displaying the message given by [message] for an amount
/// of time given by [displayTime].
void timedMessageDialog({
  required BuildContext context,
  required String message,
  required int displayTime,
}) {
  showDialog<void>(
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    context: context,
    builder: (context) {
      Future.delayed(Duration(milliseconds: displayTime), () {
        Navigator.of(context).pop();
      });
      return AlertDialog(
        title: Text(
          message,
          textAlign: TextAlign.center,
        ),
      );
    },
  );
}
