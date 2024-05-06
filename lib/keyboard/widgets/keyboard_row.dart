import 'package:flutter/material.dart';
import 'package:schrodle/keyboard/data/keys.dart';
import 'package:schrodle/keyboard/widgets/keyboard_key.dart';

/// {@template keyboard_row}
/// Renders a row of keys given inclusive [start] and [end] indices.
/// {@endtemplate}
class KeyboardRow extends StatelessWidget {
  /// {@macro keyboard_row}
  const KeyboardRow({required int start, required int end, super.key})
      : _start = start,
        _end = end;

  /// The starting index of the row in [keys].
  final int _start;

  /// The ending index of the row in [keys].
  final int _end;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = _start; i <= _end; i++) KeyboardKey(keyboardKey: keys[i]),
      ],
    );
  }
}
