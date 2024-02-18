part of 'grid_bloc.dart';

sealed class GridState extends Equatable {
  final Grid grid;
  const GridState({required this.grid});

  @override
  List<Object> get props => [grid];
}

final class GridInitial extends GridState {
  const GridInitial({required super.grid});
}

final class GridUpdated extends GridState {
  const GridUpdated({required super.grid});
}

final class GridIncomplete extends GridState {
  const GridIncomplete({required super.grid});
}

final class GridComplete extends GridState {
  const GridComplete({required super.grid});
}
