import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schrodle/game/widgets/results.dart';
import 'package:schrodle/game_grid/game_grid.dart';
import 'package:schrodle/information/information.dart';
import 'package:schrodle/keyboard/keyboard.dart';
import 'package:schrodle/theme/classes/app_colors.dart';

/// {@template game}
/// Renders the game.
/// {@endtemplate}
class Game extends StatefulWidget {
  /// {@macro game}
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  final title = 'Schrodle';
  bool? hardMode;

  /// Renders results in a dialog box.
  void _showResults(BuildContext context) {
    final results = BlocProvider.of<GameGridBloc>(context).results;
    showDialog<void>(
      context: context,
      builder: (_) => Results(results: results),
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
    return hardMode == null
      // Game mode selection
      ? Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                width: 200,
                height: 200,
                image: AssetImage('images/schrodle-light.png'),
              ),
              const Text('Welcome to Schrodle!'),
              const Text('Choose game mode'),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: const Text('Normal'),
                    onPressed: () => setState(() { hardMode = false; }),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.normal,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        side: BorderSide(color: AppColors.normal),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    child: const Text('Hard'),
                    onPressed: () => setState(() { hardMode = true; }),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.hard,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        side: BorderSide(color: AppColors.hard),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextButton.icon(
                icon: const Icon(Icons.help_outline),
                label: const Text('About the Game'),
                onPressed: () => _showInformation(context),
              ),
            ],
          ),
        )
      // Game
      : MultiBlocProvider(
          providers: [
            BlocProvider<GameGridBloc>(
              create: (BuildContext context) =>
                  GameGridBloc()..add(LoadGrid(hardMode: hardMode!)),
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
                  backgroundColor:
                      Theme.of(context).colorScheme.inversePrimary,
                  title: Text(title),
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
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(child: GameGrid(hardMode: hardMode!)),
                      const Keyboard(),
                    ],
                  ),
                ),
              );
            },
          ),
        );
  }
}
