import 'package:flutter/material.dart';
import 'package:schrodle/theme/theme.dart';

final class AppTheme {
  const AppTheme();

  ThemeData get themeData => ThemeData(
    colorScheme: _colorScheme,
    fontFamily: 'Courier Prime',
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
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(32)),
      side: BorderSide(
        color: AppColors.light,
        width: 3,
      ),
    ),
  );

  IconButtonThemeData get _iconButtonTheme => IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: AppColors.light,
    ),
  );

  TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: AppColors.button,
      foregroundColor: AppColors.light,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        side: BorderSide(color: AppColors.light),
      ),
    ),
  );
}
