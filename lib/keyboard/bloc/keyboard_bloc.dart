import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'keyboard_event.dart';
part 'keyboard_state.dart';

/// {@template keyboard_bloc}
/// Tracks the state of the keyboard and manages key events.
/// {@endtemplate}
class KeyboardBloc extends Bloc<KeyboardEvent, KeyboardState> {
  /// {@macro keyboard_bloc}
  KeyboardBloc() : super(KeyboardInitial()) {
    on<LoadKeyboard>(_loadKeyboard);
    on<KeyPress>(_keyPressed);
    on<KeyRelease>(_keyReleased);
  }

  static const Set<String> _validKeys = {
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
    'BACKSPACE', 'ENTER',
  };

  final Set<String> _keysPressed = Set<String>.identity();

  /// Emits a [KeyboardActive] state when a [LoadKeyboard] event is issued.
  void _loadKeyboard(LoadKeyboard event, Emitter<KeyboardState> emit) {
    emit(KeyboardActive());
  }

  /// When a [KeyPress] event occurs, the pressed key, if valid, is added to
  /// the set of all currently pressed keys.
  void _keyPressed(KeyPress event, Emitter<KeyboardState> emit) {
    if (state is! KeyboardActive) {
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
    if (state is! KeyboardActive) {
      return;
    }
    final key = event.key;
    _keysPressed.remove(key);
    emit(KeyboardActive());
  }

  /// Determines if a [key] is valid.
  static bool isValidKey(String key) => _validKeys.contains(key);
}
