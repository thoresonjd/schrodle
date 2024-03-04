part of 'game_bloc.dart';

/// {@template game_event}
/// The generic representation of a game event.
/// {@endtemplate}
@immutable
sealed class GameEvent extends Equatable {
  /// {@macro game_event}
  const GameEvent();

  @override
  List<Object> get props => [];
}

/// {@template load_game}
/// A [GameEvent] that triggers when the game must be initialized.
/// {@endtemplate}
class LoadGame extends GameEvent {}

/// {@template guess_made}
/// A [GameEvent] that occurs whenever a guess is made.
/// {@endtemplate}
class GuessMade extends GameEvent {
  /// {@macro guess_made}
  const GuessMade({required this.guess, required this.isValidGuess});

  /// The submitted guess.
  final String guess;

  /// Whether the guess is valid or not.
  final bool isValidGuess;
}

/// {@template game_over}
/// A [GameEvent] that triggers when the game has ended.
/// {@endtemplate}
class GameOver extends GameEvent {}
