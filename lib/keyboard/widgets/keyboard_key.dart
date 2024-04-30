import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schrodle/keyboard/utils/keyboard_utils.dart';

/// {@template keyboard_key}
/// Renders a single keyboard key.
/// {@endtemplate}
class KeyboardKey extends StatelessWidget {

  /// {@macro keyboard_key}
  const KeyboardKey({required this.keyboardKey, super.key});

  /// The underlying key represented by the [KeyboardKey] instance.
  final LogicalKeyboardKey keyboardKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        // border: Border.all(width: 2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => {handleKeyPress(context: context, key: keyboardKey)},
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 50,
              minWidth: 50,
            ),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.grey.shade800, width: 5),
                top: BorderSide(color: Colors.grey.shade800, width: 5),
                right: const BorderSide(width: 10),
                bottom: const BorderSide(width: 10),
              ),
            ),
            child: Center(
              child: Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Text(keyboardKey.keyLabel),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
