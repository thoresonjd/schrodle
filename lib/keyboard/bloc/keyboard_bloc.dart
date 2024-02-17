import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'keyboard_event.dart';
part 'keyboard_state.dart';

/// {@template keyboard_bloc}
/// Tracks the state of the keyboard and manages key events
/// {@endtemplate}
class KeyboardBloc extends Bloc<KeyboardEvent, KeyboardState> {

  /// {@macro keyboard_bloc}
  KeyboardBloc() : super(KeyboardInitial()) {
    on<LoadKeyboard>(_loadKeyboard);
    on<KeyPress>(_keyPressed);
    on<KeyRelease>(_keyReleased);
  }

  static const Set<String> _validKeys = {
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
    'backspace', 'enter',
  };

  final Set<String> _keysPressed = Set<String>.identity();

  /// Emits a [KeyboardActive] state when a [LoadKeyboard] event is issued
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
    if (_validKeys.contains(key) && !_keysPressed.contains(key)) {
      print('$key pressed');
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
    if (_keysPressed.remove(key)) {
      print('$key released');
    }
    emit(KeyboardActive());
  }
}
