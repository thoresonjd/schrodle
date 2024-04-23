import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schrodle/game_grid/game_grid.dart';
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
        BlocProvider<GameGridBloc>(
          create: (BuildContext context) => GameGridBloc()..add(LoadGrid()),
        ),
        BlocProvider<KeyboardBloc>(
          create: (BuildContext context) => 
            KeyboardBloc()..add(ActivateKeyboard(),),
        ),
      ],
      child: BlocBuilder<GameGridBloc, GameGridState>(
        builder: (BuildContext context, GameGridState state) {
          if (state is GameOver) {
            return const Text('Game Over!');
          }
          return Column(
            children: [
              Center(child: GameGrid()),
              const Keyboard(),
            ],
          );
        },
      ),
    );
  }
}
