part of 'grid_bloc.dart';

@immutable
sealed class GridEvent {
  const GridEvent();
}

class LoadGrid extends GridEvent {}

class RowForward extends GridEvent {}

class ColumnForward extends GridEvent {
  final String letter;
  const ColumnForward({required this.letter});
}

class ColumnBackward extends GridEvent {}

class CompleteGrid extends GridEvent {}
