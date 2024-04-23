import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schrodle/game_grid/game_grid.dart';
import 'package:schrodle/keyboard/keyboard.dart';

/// Handles key presses appropriately, including determination of proper
/// [GameGridEvent] to trigger given a [LogicalKeyboardKey].
void handleKeyPress({
  required BuildContext context,
  required LogicalKeyboardKey key,
}) {
  final keyboardProvider = BlocProvider.of<KeyboardBloc>(context);
  if (!keyboardProvider.isActive) {
    return;
  }
  final gameGridProvider = BlocProvider.of<GameGridBloc>(context);
  switch (key) {
    case LogicalKeyboardKey.enter:
      gameGridProvider.add(GuessMade());
      // The dialog boxes have a duration preventing the key release from
      // occuring in the Keyboard widget. For now, we can force the key
      // release here when the dialog finishes.
      keyboardProvider.add(const KeyRelease(key: LogicalKeyboardKey.enter));
    case LogicalKeyboardKey.backspace:
      gameGridProvider.add(ColumnBackward());
    default:
      gameGridProvider.add(ColumnForward(letter: key.keyLabel.toUpperCase()));
  }
}
