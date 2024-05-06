import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schrodle/keyboard/bloc/keyboard_bloc.dart';
import 'package:schrodle/keyboard/utils/handle_key_press.dart';
import 'package:schrodle/keyboard/widgets/on_screen_keyboard.dart';

/// {@template keyboard}
/// Handles keyboard input.
/// {@endtemplate}
class Keyboard extends StatelessWidget {
  /// {@macro keyboard}
  const Keyboard({super.key});

  @override
  Widget build(BuildContext context) {
    final keyboardProvider = BlocProvider.of<KeyboardBloc>(context);
    return KeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        final key = event.logicalKey;
        if (event is KeyDownEvent && keyboardProvider.canPress(key: key)) {
          keyboardProvider.add(KeyPress(key: key));
          handleKeyPress(context: context, key: key);
        } else if (event is KeyUpEvent) {
          keyboardProvider.add(KeyRelease(key: key));
        }
      },
      child: const OnScreenKeyboard(),
    );
  }
}
