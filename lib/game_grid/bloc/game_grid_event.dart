part of 'game_grid_bloc.dart';

/// {@template game_grid_event}
/// The generic representation of a game grid event.
/// {@endtemplate}
@immutable
sealed class GameGridEvent extends Equatable {
  /// {@macro grid_event}
  const GameGridEvent();

  @override
  List<Object> get props => [];
}

/// {@template load_grid}
/// A [GameGridEvent] that triggers when the grid must be initialized.
/// {@endtemplate}
class LoadGrid extends GameGridEvent {
  /// {@macro load_grid}
  const LoadGrid({required this.gameMode});

  /// Denotes which game mode shall be played.
  final GameMode gameMode;

  @override
  List<Object> get props => [gameMode];
}

/// {@template guess_made}
/// A [GameGridEvent] that occurs whenever a guess is made.
/// {@endtemplate}
class GuessMade extends GameGridEvent {}

/// {@template row_flip}
/// A [GameGridEvent] that triggers the flipping of the active row.
/// {@endtemplate}
class RowFlip extends GameGridEvent {}

/// {@template row_forward}
/// A [GameGridEvent] that occurs whenever the current row must advance forward.
/// {@endtemplate}
class RowForward extends GameGridEvent {}

/// {@template column_forward}
/// A [GameGridEvent] that occurs whenever the
/// current column must advance forward.
/// {@endtemplate}
class ColumnForward extends GameGridEvent {
  /// {@macro column_forward}
  const ColumnForward({required this.letter});

  /// The letter to place in the next column after advancing forward.
  final String letter;

  @override
  List<Object> get props => [letter];
}

/// {@template column_backward}
/// A [GameGridEvent] that occurs whenever the
/// current column must regress backward.
/// {@endtemplate}
class ColumnBackward extends GameGridEvent {}

/// {@template end_game}
/// A [GameGridEvent] that triggers when the game has ended.
/// {@endtemplate}
class EndGame extends GameGridEvent {}
