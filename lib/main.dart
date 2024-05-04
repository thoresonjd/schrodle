import 'package:flutter/material.dart';
import 'package:schrodle/game/game.dart';
import 'package:schrodle/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schrodle',
      theme: const AppTheme().themeData,
      home: const Game(),
    );
  }
}
