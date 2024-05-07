import 'package:flutter/material.dart';

/// {@template schrodle_colors}
/// The collection of colors utilized by Schrodle
/// {@endtemplate}
abstract final class SchrodleColors {
  /// No color; transparent.
  static const Color none = Colors.transparent;

  /// The lightest grayscale shade.
  static const Color light = Colors.white;

  /// The second lightest grayscale shade.
  /// The color to use when something is highlighted.
  static const Color highlight = Color(0xFF505050);

  /// The darkest grayscale shade.
  static const Color dark = Colors.black;
  
  /// The background color.
  static const Color background = Color(0xFF1E1E1E);

  /// The color rendered on an unevaluated tile.
  static const Color unevaluated = none;

  /// The color rendered on a tile where the letter
  /// is absent from the selected word.
  static const Color absent = highlight;

  /// The color rendered on a tile where the letter
  /// is present in the selected word.
  static const Color present = Color(0xFFF2B829); // Jake the Dog
  
  /// The color rendered on a tile where the letter
  /// is in the correct spot of the selected word.
  static const Color correct = Color(0xFF39a024); // Finn the Human (backpack)
  
  /// The color rendered on a tile where the letter is part
  /// of the guess that correctly matched the target word.
  static const Color guessed = Color(0xFFFF00CD); // Princess Bubblegum

  /// The color representing normal mode.
  static const Color normal = Color(0xFF66BB6A);

  /// The color representing hard mode.
  static const Color hard = Colors.red;
  
  /// The color to render on a button
  static const Color button = Colors.blue;
}
