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
  GridEvent _gridEventFromKey({required LogicalKeyboardKey key}) {
    switch (key) {
      case LogicalKeyboardKey.enter:
        return RowForward();
      case LogicalKeyboardKey.backspace:
        return ColumnBackward();
      default:
        return ColumnForward(letter: key.keyLabel.toUpperCase());
    }
  }

  /// Given a [BuildContext], constructs a callback that is called whenever
  /// a [KeyEvent] is triggered.
  void Function(KeyEvent event) _getOnKeyCallbackFromContext(
      {required BuildContext context,}) {
    final keyboardProvider = BlocProvider.of<KeyboardBloc>(context);
    final gridProvider = BlocProvider.of<GridBloc>(context);
    return (event) {
      final key = event.logicalKey;
      if (event is KeyDownEvent && keyboardProvider.canPress(key)) {
        keyboardProvider.add(KeyPress(key: key));
        gridProvider.add(_gridEventFromKey(key: key));
      } else if (event is KeyUpEvent) {
        keyboardProvider.add(KeyRelease(key: key));
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKeyEvent: _getOnKeyCallbackFromContext(context: context),
      // TODO: implement on-screen keyboard UI
      child: const SizedBox(),
    );
  }
}
