import 'package:flutter/material.dart';
import 'package:schrodle/theme/theme.dart';

final class SchrodleTheme {
  const SchrodleTheme();

  ThemeData get themeData => ThemeData(
    colorScheme: _colorScheme,
    fontFamily: 'Courier Prime',
    dialogTheme: _dialogTheme,
    iconButtonTheme: _iconButtonTheme,
    textButtonTheme: _textButtonTheme,
  );

  ColorScheme get _colorScheme => const ColorScheme.dark(
    background: SchrodleColors.background,
  );

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

  IconButtonThemeData get _iconButtonTheme => IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: SchrodleColors.light,
    ),
  );

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
