part of 'keyboard_bloc.dart';

/// {@template keyboard_event}
/// The generic representation of a keyboard event.
/// {@endtemplate}
@immutable
sealed class KeyboardEvent {
  const KeyboardEvent();
}

/// {@template load_keyboard}
/// A [KeyboardEvent] that triggers when the keyboard must be initialized.
/// {@endtemplate}
class LoadKeyboard extends KeyboardEvent {}

/// {@template key_press}
/// A [KeyboardEvent] that occurs whenever a [key] is pressed.
/// {@endtemplate}
class KeyPress extends KeyboardEvent {

  /// {@macro key_press}
  const KeyPress({required this.key});
  
  /// The lowercase [String] representation of the pressed key.
  final String key;
}

/// {@template key_release}
/// A [KeyboardEvent] that occurs whenever a [key] is released.
/// {@endtemplate}
class KeyRelease extends KeyboardEvent {
  
  /// {@macro key_release}
  const KeyRelease({required this.key});

  /// The lowercase [String] representation of the released key.
  final String key;
}
