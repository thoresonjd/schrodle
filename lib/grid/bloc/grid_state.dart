part of 'grid_bloc.dart';

/// {@template grid_state}
/// The generic representation of a grid state.
/// {@endtemplate}
@immutable
sealed class GridState extends Equatable {
  /// {@macro grid_state}
  const GridState({required this.grid});

  /// The value (layout) of the grid.
  final Grid grid;

  @override
  List<Object> get props => [grid];
}

/// {@template grid_initial}
/// A [GridState] representing the initial state of the grid.
/// {@endtemplate}
final class GridInitial extends GridState {
  /// {@macro grid_initial}
  const GridInitial({required super.grid});
}

/// {@template grid_row_flipping}
/// A [GridState] indicating that the active row is undergoing a flip animation.
/// {@endtemplate}
final class GridRowFlipping extends GridState {
  /// {@macro grid_row_flipping}
  const GridRowFlipping({required this.row, required super.grid});
  
  /// The active row number undergoing a flip animation.
  final int row;

  @override
  List<Object> get props => [super.grid, row];
}

/// {@template grid_updated}
/// A [GridState] representing the grid when it has been recently updated.
/// Serves as an intermediate state between two differend [GridIncomplete]
/// states such that the grid state can be updated based on a recognized change
/// of state. Two distict state types are required to reflect a state change.
/// {@endtemplate}
final class GridUpdated extends GridState {
  /// {@macro grid_updated}
  const GridUpdated({required super.grid});
}

/// {@template grid_incomplete}
/// A [GridState] representing the grid when it is still in an incomplete stage.
/// {@endtemplate}
final class GridIncomplete extends GridState {
  /// {@macro grid_incomplete}
  const GridIncomplete({required super.grid});
}

/// {@template grid_complete}
/// A [GridState] representing the grid when it has been completed.
/// {@endtemplate}
final class GridComplete extends GridState {
  /// {@macro grid_complete}
  const GridComplete({required super.grid});
}
