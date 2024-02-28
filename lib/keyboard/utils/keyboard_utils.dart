import 'package:flutter/services.dart';
import 'package:schrodle/grid/bloc/grid_bloc.dart';

/// Determines the appropriate [GridEvent] to
/// trigger given a [LogicalKeyboardKey].
GridEvent gridEventFromKey({required LogicalKeyboardKey key}) {
  switch (key) {
    case LogicalKeyboardKey.enter:
      return RowForward();
    case LogicalKeyboardKey.backspace:
      return ColumnBackward();
    default:
      return ColumnForward(letter: key.keyLabel.toUpperCase());
  }
}
