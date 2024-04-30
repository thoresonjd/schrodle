import 'package:flutter/material.dart';
import 'package:schrodle/theme/theme.dart';

final class AppTheme {
  const AppTheme();

  ThemeData get themeData => ThemeData(
    colorScheme: _colorScheme,
    dialogTheme: _dialogTheme,
    iconButtonTheme: _iconButtonTheme,
    textButtonTheme: _textButtonTheme,
  );

  ColorScheme get _colorScheme => const ColorScheme.dark(
    background: AppColors.background,
  );

  DialogTheme get _dialogTheme => const DialogTheme(
    backgroundColor: AppColors.background,
    surfaceTintColor: AppColors.none,
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
