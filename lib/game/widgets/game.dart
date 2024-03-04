import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schrodle/game/game.dart';
import 'package:schrodle/grid/grid.dart';
import 'package:schrodle/keyboard/keyboard.dart';

/// {@template game}
/// Renders the game.
/// {@endtemplate}
class Game extends StatelessWidget {
  /// {@macro game}
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameBloc>(
          create: (BuildContext context) => GameBloc()..add(LoadGame()),
        ),
        BlocProvider<GridBloc>(
          create: (BuildContext context) => GridBloc()..add(LoadGrid()),
        ),
        BlocProvider<KeyboardBloc>(
          create: (BuildContext context) => KeyboardBloc()..add(LoadKeyboard()),
        ),
      ],
      child: Column(
        children: [
          Center(child: Grid()),
          const Keyboard(),
        ],
      ),
    );
  }
}
