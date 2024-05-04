import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schrodle/keyboard/utils/keyboard_utils.dart';
import 'package:schrodle/theme/theme.dart';

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
      margin: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: AppColors.background,
      ),
      child: Material(
        color: AppColors.none,
        child: InkWell(
          onTap: () => {handleKeyPress(context: context, key: keyboardKey)},
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: AppColors.highlight, width: 5),
                top: BorderSide(color: AppColors.highlight, width: 5),
                right: BorderSide(width: 10),
                bottom: BorderSide(width: 10),
              ),
            ),
            child: Center(
              child: Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Text(
                  keyboardKey.keyLabel,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
