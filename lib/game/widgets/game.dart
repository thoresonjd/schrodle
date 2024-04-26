import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schrodle/game/widgets/results.dart';
import 'package:schrodle/game_grid/game_grid.dart';
import 'package:schrodle/information/information.dart';
import 'package:schrodle/keyboard/keyboard.dart';

/// {@template game}
/// Renders the game.
/// {@endtemplate}
class Game extends StatelessWidget {
  /// {@macro game}
  const Game({super.key});

  static const _title = 'Schrodle';

  /// Renders results in a dialog box.
  void _showResults(BuildContext context) {
    final results = BlocProvider.of<GameGridBloc>(context).results;
    showDialog<void>(
      context: context,
      builder: (_) => Results(results: results)
    );
  }

  /// Renders information in a dialog box.
  void _showInformation(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => const Information(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameGridBloc>(
          create: (BuildContext context) => GameGridBloc()..add(LoadGrid()),
        ),
        BlocProvider<KeyboardBloc>(
          create: (BuildContext context) => KeyboardBloc()
            ..add(
              ActivateKeyboard(),
            ),
        ),
      ],
      child: BlocConsumer<GameGridBloc, GameGridState>(
        listener: (BuildContext context, GameGridState state) {
          if (state is GameOver) {
            _showResults(context);
          }
        },
        builder: (BuildContext context, GameGridState state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text(_title),
              actions: [
                if (state is GameOver)
                  IconButton(
                    icon: const Icon(Icons.bar_chart),
                    onPressed: () => _showResults(context),
                  ),
                IconButton(
                  icon: const Icon(Icons.help_outline),
                  onPressed: () => _showInformation(context),
                ),
              ],
            ),
            body: Column(
              children: [
                Center(child: GameGrid()),
                const Keyboard(),
              ],
            ),
          );
        },
      ),
    );
  }
}
