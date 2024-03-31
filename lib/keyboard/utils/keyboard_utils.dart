import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schrodle/dialog/dialog.dart';
import 'package:schrodle/game/game.dart';
import 'package:schrodle/grid/grid.dart';
import 'package:schrodle/keyboard/keyboard.dart';

/// Handles key presses appropriately, including determination of proper
/// [GridEvent] to trigger given a [LogicalKeyboardKey].
void handleKeyPress({
  required BuildContext context,
  required LogicalKeyboardKey key,
}) {
  final gameProvider = BlocProvider.of<GameBloc>(context);
  final gridProvider = BlocProvider.of<GridBloc>(context);
  final keyboardProvider = BlocProvider.of<KeyboardBloc>(context);
  switch (key) {
    case LogicalKeyboardKey.enter:
      late final String guess;
      try {
        guess = gridProvider.currentRowAsString();
      } on Exception {
        dialog(
          context: context,
          message: 'NOT ENOUGH LETTERS',
          displayTime: 1000,
        );
        // The dialog box has a duration preventing the key release from
        // occuring in the Keyboard widget. For now, we can force the key
        // release here when the dialog finishes.
        keyboardProvider.add(const KeyRelease(key: LogicalKeyboardKey.enter));
        return;
      }
      if (!gameProvider.isValidGuess(guess)) {
        dialog(context: context, message: 'INVALID GUESS', displayTime: 1000);
        // Force key release
        keyboardProvider.add(const KeyRelease(key: LogicalKeyboardKey.enter));
        return;
      }
      gameProvider.updateGridStatus(guess);
      gridProvider.updateRowColors(gameProvider.currentRowStatus);
      gameProvider.add(GuessMade(guess: guess));
      gridProvider.add(RowFlip());
    case LogicalKeyboardKey.backspace:
      gridProvider.add(ColumnBackward());
    default:
      gridProvider.add(ColumnForward(letter: key.keyLabel.toUpperCase()));
  }
}
