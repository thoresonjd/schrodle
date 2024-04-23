part of 'keyboard_bloc.dart';

/// {@template keyboard_state}
/// The generic representation of a keyboard state.
/// {@endtemplate}
@immutable
sealed class KeyboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// {@template keyboard_inactive}
/// A [KeyboardState] indicating that the keyboard is inactive.
/// {@endtemplate}
final class KeyboardInactive extends KeyboardState {}

/// {@template keyboard_active}
/// A [KeyboardState] indicating that the keyboard is active.
/// {@endtemplate}
final class KeyboardActive extends KeyboardState {}
