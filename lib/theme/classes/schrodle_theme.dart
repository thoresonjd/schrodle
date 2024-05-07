import 'package:flutter/material.dart';
import 'package:schrodle/theme/theme.dart';

/// {@template schrodle_theme}
/// The general style specifications for Schrodle.
/// {@endtemplate}
final class SchrodleTheme {
  /// {@macro schrodle_theme}
  const SchrodleTheme();

  /// The main theme specification.
  ThemeData get themeData => ThemeData(
    colorScheme: _colorScheme,
    fontFamily: 'Courier Prime',
    dialogTheme: _dialogTheme,
    iconButtonTheme: _iconButtonTheme,
    textButtonTheme: _textButtonTheme,
  );

  /// The general color scheme of Schrodle.
  ColorScheme get _colorScheme => const ColorScheme.dark(
    background: SchrodleColors.background,
  );

  /// The theme of a dialog box.
  DialogTheme get _dialogTheme => const DialogTheme(
    backgroundColor: SchrodleColors.background,
    surfaceTintColor: SchrodleColors.none,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(32)),
      side: BorderSide(
        color: SchrodleColors.light,
        width: 3,
      ),
    ),
  );

  /// The theme of an [IconButton].
  IconButtonThemeData get _iconButtonTheme => IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: SchrodleColors.light,
    ),
  );

  /// The theme of a [TextButton].
  TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: SchrodleColors.button,
      foregroundColor: SchrodleColors.light,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        side: BorderSide(color: SchrodleColors.light),
      ),
    ),
  );
}
