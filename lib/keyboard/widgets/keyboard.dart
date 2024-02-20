import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schrodle/grid/grid.dart';
import 'package:schrodle/keyboard/bloc/keyboard_bloc.dart';

/// {@template keyboard}
/// Handles keyboard input
/// {@endtemplate}
class Keyboard extends StatelessWidget {
  
  /// {@macro keyboard}
  const Keyboard({super.key});

  /// Determines the appropriate [GridEvent] to
  /// trigger given a [LogicalKeyboardKey].
  GridEvent _gridEventFromKey(LogicalKeyboardKey key) {
    switch (key) {
      case LogicalKeyboardKey.enter:
        return RowForward();
      case LogicalKeyboardKey.backspace:
        return ColumnBackward();
      default:
        return ColumnForward(letter: key.keyLabel.toUpperCase());
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (event) {
        final keyboardProvider = BlocProvider.of<KeyboardBloc>(context);
        final gridProvider = BlocProvider.of<GridBloc>(context);
        final key = event.logicalKey;
        if (event is RawKeyDownEvent && KeyboardBloc.isValidKey(key)) {
          keyboardProvider.add(KeyPress(key: key));
          gridProvider.add(_gridEventFromKey(key));
        } else if (event is RawKeyUpEvent) {
          keyboardProvider.add(KeyRelease(key: key));
        }
      },
      // TODO: implement on-screen keyboard UI
      child: const SizedBox(),
    );
  }
}
