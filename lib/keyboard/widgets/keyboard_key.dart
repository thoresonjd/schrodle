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
    return GestureDetector(
      onTap: () => {handleKeyPress(context: context, key: keyboardKey)},
      child: Card(
        child: Text(keyboardKey.keyLabel),
      ),
    );
  }
}
