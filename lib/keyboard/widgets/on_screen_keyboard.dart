import 'package:flutter/material.dart';
import 'package:schrodle/keyboard/widgets/keyboard_row.dart';

/// {@template on_screen_keyboard}
/// Renders the UI of an on-screen keyboard.
/// {@endtemplate}
class OnScreenKeyboard extends StatelessWidget {

  /// {@macro on_screen_keyboard}
  const OnScreenKeyboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        KeyboardRow(start: 0, end: 9),
        KeyboardRow(start: 10, end: 18),
        KeyboardRow(start: 19, end: 27),
      ],
    );
  }
}
