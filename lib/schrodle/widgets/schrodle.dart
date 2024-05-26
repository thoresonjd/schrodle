import 'package:flutter/material.dart';
import 'package:schrodle/game_grid/game_grid.dart';
import 'package:schrodle/theme/theme.dart';

/// {@template schrodle}
/// The root Schrodle widget.
/// {@endtemplate}
class Schrodle extends StatelessWidget {
  /// {@macro schrodle}
  const Schrodle({super.key});

  static const String _title = 'Schrodle';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: const SchrodleTheme().themeData,
      home: const Game(),
    );
  }
}
