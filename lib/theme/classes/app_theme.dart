import 'package:flutter/material.dart';
import 'package:schrodle/theme/theme.dart';

final class AppTheme {
  const AppTheme();

  ThemeData get themeData => ThemeData(
    colorScheme: _colorScheme,
    iconButtonTheme: _iconButtonTheme,
    textButtonTheme: _textButtonTheme,
  );

  ColorScheme get _colorScheme => const ColorScheme.dark(
    background: Color.fromRGBO(25, 25, 25, 1),
  );

  IconButtonThemeData get _iconButtonTheme => IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: AppColors.light,
    ),
  );

  TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
    style: TextButton.styleFrom(
      iconColor: AppColors.light,
      foregroundColor: AppColors.light,
    ),
  );
}
