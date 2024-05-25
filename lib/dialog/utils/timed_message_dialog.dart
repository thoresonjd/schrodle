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
    builder: (_) {
      Future.delayed(Duration(milliseconds: displayTime), () {
        Navigator.of(_).maybePop();
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
