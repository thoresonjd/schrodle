import 'package:schrodle/game_grid/constants/tile_status.dart';

const Map<TileStatus, String> tileStatusEmojis = {
  TileStatus.guessed: '🟪',
  TileStatus.correct: '🟩',
  TileStatus.present: '🟨',
  TileStatus.absent: '⬛',
  TileStatus.unoccupied: '⬛',
  TileStatus.occupied: '⬛',
};
