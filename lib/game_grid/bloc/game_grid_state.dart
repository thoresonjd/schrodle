part of 'game_grid_bloc.dart';

/// {@template game_grid_state}
/// The generic representation of a grid state.
/// {@endtemplate}
@immutable
sealed class GameGridState extends Equatable {
  /// {@macro grid_state}
  const GameGridState({required this.grid});

  /// The value (layout) of the grid.
  final Grid grid;

  @override
  List<Object> get props => [grid];
}

/// {@template grid_initial}
/// A [GameGridState] representing the initial state of the grid.
/// {@endtemplate}
final class GameGridInitial extends GameGridState {
  /// {@macro grid_initial}
  const GameGridInitial({required super.grid});
}

/// {@template game_in_progress}
/// A [GameGridState] denoting that the game is currently in progress.
/// {@endtemplate}
final class GameInProgress extends GameGridState {
  /// {@macro grid_incomplete}
  const GameInProgress({required super.grid});
}

/// {@template guess_evaluated}
/// A [GameGridState] denoted that the most recent guess has been evaluated.
/// {@endtemplate}
final class GuessEvaluated extends GameGridState {
  /// {@macro guess_evaluated}
  const GuessEvaluated({required super.grid, this.message});

  /// The message associated with the guess evaluation, if any.
  final String? message;
}

/// {@template row_flipping}
/// A [GameGridState] indicating that the active row
/// is undergoing a flip animation.
/// {@endtemplate}
final class RowFlipping extends GameGridState {
  /// {@macro grid_row_flipping}
  const RowFlipping({required this.row, required super.grid});

  /// The active row number undergoing a flip animation.
  final int row;

  @override
  List<Object> get props => [super.grid, row];
}

/// {@template grid_updated}
/// A [GameGridState] representing the grid when it has been recently updated.
/// Serves as an intermediate state between two differend [GameInProgress]
/// states such that the grid state can be updated based on a recognized change
/// of state. Two distict state types are required to reflect a state change.
/// {@endtemplate}
final class GridUpdated extends GameGridState {
  /// {@macro grid_updated}
  const GridUpdated({required super.grid});
}

/// {@template game_over}
/// A [GameGridState] indicating that the game is over.
/// {@endtemplate}
final class GameOver extends GameGridState {
  /// {@macro game_over}
  const GameOver({required super.grid});
}
