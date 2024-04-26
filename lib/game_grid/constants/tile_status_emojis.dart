import 'package:schrodle/game_grid/constants/tile_status.dart';

const Map<TileStatus, String> tileStatusEmojis = {
  TileStatus.guessed: '🟦',
  TileStatus.correctSpot: '🟩',
  TileStatus.present: '🟨',
  TileStatus.notPresent: '🟥',
  TileStatus.unoccupied: '🟥',
  TileStatus.occupied: '🟥',
};
