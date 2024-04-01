part of 'game_bloc.dart';

/// {@template game_state}
/// The generic representation of a game state.
/// {@endtemplate}
@immutable
sealed class GameState extends Equatable {
  /// {@macro game_state}
  const GameState();

  @override
  List<Object> get props => [];
}

/// {@template game_initial}
/// A [GameState] representing the initial state of the game.
/// {@endtemplate}
final class GameInitial extends GameState {}

/// {@template game_in_progress}
/// A [GameState] indicating that the game is in progress.
/// {@endtemplate}
final class GameInProgress extends GameState {
  /// {@macro game_in_progress}
  const GameInProgress();
}

/// {@template game_over}
/// A [GameState] indicating that the game is over.
/// {@endtemplate}
final class GameOver extends GameState {
  /// {@macro game_over}
  const GameOver({required this.won, required this.targetWord});

  /// Determines if the game had been won or lost.
  final bool won;

  /// The Schrodle solution.
  final String targetWord;
}
