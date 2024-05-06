import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schrodle/game_grid/bloc/game_grid_bloc.dart';
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
            image: AssetImage('images/schrodle-light.png'),
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
                  hardMode = false;
                }),
                style: TextButton.styleFrom(
                  backgroundColor: SchrodleColors.normal,
                ),
                child: const Text('Normal'),
              ),
              const SizedBox(width: sectionSpacing),
              TextButton(
                onPressed: () => setState(() {
                  hardMode = true;
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

  Widget _game(BuildContext context) {
    const title = 'Schrodle';
    const sectionSpacing = 15.0;
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameGridBloc>(
          create: (BuildContext context) =>
              GameGridBloc()..add(LoadGrid(hardMode: hardMode!)),
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
                  const SizedBox(height: sectionSpacing),
                  Center(child: Grid(hardMode: hardMode!)),
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
    return hardMode == null ? _landing() : _game(context);
  }
}
