import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schrodle/keyboard/utils/handle_key_press.dart';
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
    const keySpacing = 2.0;
    const textMargin = 5.0;
    const borderHighlightSize = 5.0;
    const borderShadowSize = 10.0;
    const textSize = 20.0;
    return Container(
      margin: const EdgeInsets.all(keySpacing),
      decoration: const BoxDecoration(
        color: SchrodleColors.background,
      ),
      child: Material(
        color: SchrodleColors.none,
        child: InkWell(
          onTap: () => {handleKeyPress(context: context, key: keyboardKey)},
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: SchrodleColors.highlight,
                  width: borderHighlightSize,
                ),
                top: BorderSide(
                  color: SchrodleColors.highlight,
                  width: borderHighlightSize,
                ),
                right: BorderSide(width: borderShadowSize),
                bottom: BorderSide(width: borderShadowSize),
              ),
            ),
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(
                  left: textMargin,
                  right: textMargin,
                ),
                child: Text(
                  keyboardKey.keyLabel,
                  style: const TextStyle(
                    fontSize: textSize,
                    fontWeight: FontWeight.bold,
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
