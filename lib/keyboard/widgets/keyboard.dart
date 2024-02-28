import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schrodle/grid/grid.dart';
import 'package:schrodle/keyboard/bloc/keyboard_bloc.dart';
import 'package:schrodle/keyboard/utils/keyboard_utils.dart';
import 'package:schrodle/keyboard/widgets/on_screen_keyboard.dart';


/// {@template keyboard}
/// Handles keyboard input.
/// {@endtemplate}
class Keyboard extends StatelessWidget {
  /// {@macro keyboard}
  const Keyboard({super.key});

  /// Given a [BuildContext], constructs a callback that is called whenever
  /// a [KeyEvent] is triggered.
  static void Function(KeyEvent event) _getOnKeyCallbackFromContext({
    required BuildContext context,
  }) {
    final keyboardProvider = BlocProvider.of<KeyboardBloc>(context);
    final gridProvider = BlocProvider.of<GridBloc>(context);
    return (event) {
      final key = event.logicalKey;
      if (event is KeyDownEvent && keyboardProvider.canPress(key)) {
        keyboardProvider.add(KeyPress(key: key));
        gridProvider.add(gridEventFromKey(key: key));
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
      child: const OnScreenKeyboard(),
    );
  }
}
