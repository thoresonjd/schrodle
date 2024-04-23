import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:schrodle/keyboard/data/keys.dart';

part 'keyboard_event.dart';
part 'keyboard_state.dart';

/// {@template keyboard_bloc}
/// Tracks the state of the keyboard and manages key events.
/// {@endtemplate}
class KeyboardBloc extends Bloc<KeyboardEvent, KeyboardState> {
  /// {@macro keyboard_bloc}
  KeyboardBloc() : super(KeyboardInactive()) {
    on<ActivateKeyboard>(_activateKeyboard);
    on<DeactivateKeyboard>(_deactivateKeyboard);
    on<KeyPress>(_keyPressed);
    on<KeyRelease>(_keyReleased);
  }

  /// The set of all keys currently being pressed.
  final Set<LogicalKeyboardKey> _keysPressed = <LogicalKeyboardKey>{};

  /// Retrieves the active status of the keyboard.
  bool get isActive => state is KeyboardActive;

  /// Activates the keyboard.
  void _activateKeyboard(ActivateKeyboard event, Emitter<KeyboardState> emit) {
    emit(KeyboardActive());
  }

  /// Deactivates the keyboard.
  void _deactivateKeyboard(
    DeactivateKeyboard event,
    Emitter<KeyboardState> emit,
  ) {
    emit(KeyboardInactive());
  }

  /// When a [KeyPress] event occurs, the pressed key, if valid, is added to
  /// the set of all currently pressed keys.
  void _keyPressed(KeyPress event, Emitter<KeyboardState> emit) {
    if (state is KeyboardInactive) {
      return;
    }
    final key = event.key;
    if (!_keysPressed.contains(key)) {
      _keysPressed.add(key);
    }
    emit(KeyboardActive());
  }

  /// When a [KeyRelease] event occurs, the released key, if contained in the
  /// set of all currently pressed keys, is removed.
  void _keyReleased(KeyRelease event, Emitter<KeyboardState> emit) {
    if (state is KeyboardInactive) {
      return;
    }
    final key = event.key;
    _keysPressed.remove(key);
    emit(KeyboardActive());
  }

  /// Determines if a [key] is can be pressed. A key can be pressed if it is
  /// contained in the set of all keys accepted by the game and not contained
  /// in the set of all currently pressed keys.
  bool canPress(LogicalKeyboardKey key) =>
      keys.contains(key) && !_keysPressed.contains(key);
}
