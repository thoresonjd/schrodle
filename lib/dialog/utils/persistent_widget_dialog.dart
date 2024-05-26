import 'package:flutter/material.dart';

/// Renders a [Widget] in a persistent, closable dialog box.
void persistentWidgetDialog({
  required BuildContext context,
  required Widget widget,
}) {
  final size = MediaQuery.of(context).size;
  final paddingHorizontal = size.width * 0.1;
  final paddingVertical = size.height * 0.1;
  showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
      insetPadding: EdgeInsets.fromLTRB(
        paddingHorizontal,
        paddingVertical,
        paddingHorizontal,
        paddingVertical,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                alignment: Alignment.centerRight,
                onPressed: () => Navigator.maybePop(_),
                icon: const Icon(Icons.clear),
              ),
            ),
            widget,
          ],
        ),
      ),
    ),
  );
}
