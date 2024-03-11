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

/// {@template game_won}
/// A [GameState] indicating that the game has been won.
/// {@endtemplate}
final class GameWon extends GameState {}

/// {@template game_lost}
/// A [GameState] indicating that the game has been lost.
/// {@endtemplate}
final class GameLost extends GameState {}
