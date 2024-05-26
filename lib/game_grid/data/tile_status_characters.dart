import 'package:schrodle/game_grid/data/tile_status.dart';

/// Mapping of each [TileStatus] and their corresponding characters.
const Map<TileStatus, String> tileStatusCharacters = {
  TileStatus.guessed: '🟪',
  TileStatus.correct: '🟩',
  TileStatus.present: '🟨',
  TileStatus.absent: '⬛',
  TileStatus.unoccupied: '⬛',
  TileStatus.occupied: '⬛',
};
