import 'package:flutter/material.dart';
import 'package:schrodle/game_grid/game_grid.dart';
import 'package:schrodle/theme/theme.dart';

class Schrodle extends StatelessWidget {
  const Schrodle({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schrodle',
      theme: const SchrodleTheme().themeData,
      home: const Game(),
    );
  }
}
