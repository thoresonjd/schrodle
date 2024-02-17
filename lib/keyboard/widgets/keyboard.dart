import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schrodle/keyboard/bloc/keyboard_bloc.dart';

/// {@template keyboard}
/// Handles keyboard input
/// {@endtemplate}
class Keyboard extends StatelessWidget {

  /// {@macro keyboard}
  const Keyboard({super.key});

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (event) {
        final key = event.logicalKey.keyLabel.toLowerCase();
        if (event is RawKeyDownEvent) {
          BlocProvider.of<KeyboardBloc>(context).add(KeyPress(key: key));
        } else if (event is RawKeyUpEvent) {
          BlocProvider.of<KeyboardBloc>(context).add(KeyRelease(key: key));
        }
      },
      // TODO: implement on-screen keyboard UI
      child: const SizedBox(),
    );
  }
}
