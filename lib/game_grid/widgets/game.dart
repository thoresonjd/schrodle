import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schrodle/confetti/widgets/confetti.dart';
import 'package:schrodle/dialog/dialog.dart';
import 'package:schrodle/game_grid/bloc/game_grid_bloc.dart';
import 'package:schrodle/game_grid/data/game_mode.dart';
import 'package:schrodle/game_grid/widgets/grid.dart';
import 'package:schrodle/game_grid/widgets/results.dart';
import 'package:schrodle/information/information.dart';
import 'package:schrodle/keyboard/keyboard.dart';
import 'package:schrodle/theme/theme.dart';

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
  /// The mode in which the game shall be played.
  GameMode? gameMode;

  /// Renders game results in a dialog box.
  void _showResults(BuildContext context) {
    final results = BlocProvider.of<GameGridBloc>(context).results;
    persistentWidgetDialog(context: context, widget: Results(results: results));
  }

  /// Renders game information in a dialog box.
  void _showInformation(BuildContext context) {
    persistentWidgetDialog(context: context, widget: const Information());
  }

  /// Renders game's landing page, which includes game mode selection.
  Widget _landing() {
    const logoSize = 150.0;
    const sectionSpacing = 10.0;
    const textSize = 20.0;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            width: logoSize,
            height: logoSize,
            image: AssetImage('assets/images/schrodle-light.png'),
          ),
          const Text(
            'Welcome to Schrodle!',
            style: SchrodleTypography.subheading,
          ),
          const Text(
            'Choose a game mode',
            style: TextStyle(
              fontSize: textSize,
            ),
          ),
          const SizedBox(height: sectionSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => setState(() {
                  gameMode = GameMode.normal;
                }),
                style: TextButton.styleFrom(
                  backgroundColor: SchrodleColors.normal,
                ),
                child: const Text('Normal'),
              ),
              const SizedBox(width: sectionSpacing),
              TextButton(
                onPressed: () => setState(() {
                  gameMode = GameMode.probabilistic;
                }),
                style: TextButton.styleFrom(
                  backgroundColor: SchrodleColors.probabilistic,
                ),
                child: const Text('Probabilistic'),
              ),
              const SizedBox(width: sectionSpacing),
              TextButton(
                onPressed: () => setState(() {
                  gameMode = GameMode.hard;
                }),
                style: TextButton.styleFrom(
                  backgroundColor: SchrodleColors.hard,
                ),
                child: const Text('Hard'),
              ),
            ],
          ),
          const SizedBox(height: sectionSpacing),
          TextButton.icon(
            icon: const Icon(Icons.help_outline),
            label: const Text('Learn more'),
            onPressed: () => _showInformation(context),
          ),
        ],
      ),
    );
  }

  /// Renders the game components, which include the grid and the keyboard.
  Widget _game(BuildContext context) {
    const title = 'Schrodle';
    const sectionSpacing = 7.5;
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameGridBloc>(
          create: (BuildContext context) =>
              GameGridBloc()..add(LoadGrid(gameMode: gameMode!)),
        ),
        BlocProvider<KeyboardBloc>(
          create: (BuildContext context) =>
              KeyboardBloc()..add(DeactivateKeyboard()),
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
              title: const Text(title),
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
                  if (state is GameOver && state.won)
                    const Confetti(),
                  const SizedBox(height: sectionSpacing),
                  Center(child: Grid(gameMode: gameMode!)),
                  const SizedBox(height: sectionSpacing),
                  const Keyboard(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return gameMode == null ? _landing() : _game(context);
  }
}
