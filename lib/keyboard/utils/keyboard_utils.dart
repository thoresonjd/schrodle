import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schrodle/game/game.dart';
import 'package:schrodle/grid/grid.dart';

/// Handles key presses appropriately, including determination of proper
/// [GridEvent] to trigger given a [LogicalKeyboardKey].
void handleKeyPress({
  required BuildContext context,
  required LogicalKeyboardKey key,
}) {
  final gameProvider = BlocProvider.of<GameBloc>(context);
  final gridProvider = BlocProvider.of<GridBloc>(context);
  switch (key) {
    case LogicalKeyboardKey.enter:
      late final String guess;
      try {
        guess = gridProvider.getRow();
        final isValidGuess = gameProvider.isValidGuess(guess);
        gameProvider.add(GuessMade(guess: guess, isValidGuess: isValidGuess));
        if (isValidGuess) {
          gridProvider.add(RowFlip());
        }
      // ignore: empty_catches
      } on Exception {}
    case LogicalKeyboardKey.backspace:
      gridProvider.add(ColumnBackward());
    default:
      gridProvider.add(ColumnForward(letter: key.keyLabel.toUpperCase()));
  }
}
