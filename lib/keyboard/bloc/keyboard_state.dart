part of 'keyboard_bloc.dart';

/// {@template keyboard_state}
/// The generic representation of a keyboard state.
/// {@endtemplate}
@immutable
sealed class KeyboardState {}

/// {@template keyboard_initial}
/// A [KeyboardState] representing the initial inactive state of the keyboard.
/// {@endtemplate}
final class KeyboardInitial extends KeyboardState {}

/// {@template keyboard_active}
/// A [KeyboardState] indicating that the keyboard is active.
/// {@endtemplate}
final class KeyboardActive extends KeyboardState {}
