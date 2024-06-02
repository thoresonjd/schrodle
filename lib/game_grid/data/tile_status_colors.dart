import 'dart:ui';
import 'package:schrodle/game_grid/data/tile_status.dart';
import 'package:schrodle/theme/classes/schrodle_colors.dart';

/// Retrieves the [Color] for the corresponding [TileStatus].
const Map<TileStatus, Color> tileStatusColors = {
  TileStatus.guessed: SchrodleColors.guessed,
  TileStatus.correct: SchrodleColors.correct,
  TileStatus.present: SchrodleColors.present,
  TileStatus.absent: SchrodleColors.absent,
  TileStatus.occupied: SchrodleColors.unevaluated,
  TileStatus.unoccupied: SchrodleColors.unevaluated,
};
