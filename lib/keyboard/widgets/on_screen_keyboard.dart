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
    const row1End = 9;
    const row2End = 18;
    const row3End = 25;
    const row4End = 27;
    const row1Start = 0;
    const row2Start = row1End + 1;
    const row3Start = row2End + 1;
    const row4Start = row3End + 1;
    return const Column(
      children: [
        KeyboardRow(start: row1Start, end: row1End),
        KeyboardRow(start: row2Start, end: row2End),
        KeyboardRow(start: row3Start, end: row3End),
        KeyboardRow(start: row4Start, end: row4End),
      ],
    );
  }
}
