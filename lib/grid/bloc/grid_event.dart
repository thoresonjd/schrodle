part of 'grid_bloc.dart';

/// {@template grid_event}
/// The generic representation of a grid event.
/// {@endtemplate}
@immutable
sealed class GridEvent {

  /// {@macro grid_event}
  const GridEvent();
}

/// {@template load_grid}
/// A [GridEvent] that triggers when the grid must be initialized.
/// {@endtemplate}
class LoadGrid extends GridEvent {}

/// {@template row_forward}
/// A [GridEvent] that occurs whenever the current row must advance forward.
/// {@endtemplate}
class RowForward extends GridEvent {}

/// {@template column_forward}
/// A [GridEvent] that occurs whenever the current column must advance forward.
/// {@endtemplate}
class ColumnForward extends GridEvent {

  /// {@macro column_forward}
  const ColumnForward({required this.letter});

  /// The letter to place in the next column after advancing forward.
  final String letter;
}

/// {@template column_backward}
/// A [GridEvent] that occurs whenever the current column must regress backward.
/// {@endtemplate}
class ColumnBackward extends GridEvent {}

/// {@template complete_grid}
/// A [GridEvent] that triggers when the grid is completed.
/// {@endtemplate}
class CompleteGrid extends GridEvent {}
