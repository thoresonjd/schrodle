import 'package:equatable/equatable.dart';
import 'package:schrodle/game_grid/data/tile_status.dart';

/// {@template tile}
/// Model representing a grid tile.
/// {@endtemplate}
class Tile extends Equatable {

  /// {@macro tile}
  const Tile({required this.status, this.letter = ''});

  /// The [TileStatus] of the tile.
  final TileStatus status;

  /// The letter contained in the tile.
  final String letter;

  @override
  List<Object?> get props => [status, letter];
}
