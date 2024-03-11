import 'package:equatable/equatable.dart';
import 'package:schrodle/grid/models/tile.dart';

/// {@template grid}
/// Model representing the grid layout.
/// {@endtemplate}
class Grid extends Equatable {

  /// {@macro grid}
  const Grid({required this.tiles});

  /// The two-dimensional layout of all tiles in the grid.
  final List<List<Tile>> tiles;

  /// Retrieves the tile at the location of [row] and [column].
  Tile at({required int row, required int column}) =>
      tiles[row][column];

  @override
  List<Object?> get props => [tiles];
}
