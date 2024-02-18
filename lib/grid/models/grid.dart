import 'package:equatable/equatable.dart';
import 'package:schrodle/grid/models/tile.dart';

class Grid extends Equatable {
  final List<List<Tile>> tiles;
  Grid({required this.tiles});

  String? letterAt({required int row, required int column}) =>
      tiles[row][column].letter;

  @override
  List<Object?> get props => [tiles];
}
