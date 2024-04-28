import 'package:flutter/material.dart';
import 'package:schrodle/theme/theme.dart';

final class AppTheme {
  const AppTheme();

  ThemeData get themeData => ThemeData(
    colorScheme: _colorScheme,
    cardTheme: _cardtheme,
    iconButtonTheme: _iconButtonTheme,
    textButtonTheme: _textButtonTheme,
  );

  ColorScheme get _colorScheme => const ColorScheme.dark();

  CardTheme get _cardtheme => const CardTheme(
    shape: RoundedRectangleBorder(
      side: BorderSide(color: AppColors.light),
    ),
    margin: EdgeInsets.zero,
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
