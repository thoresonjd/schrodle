import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schrodle/game_grid/bloc/game_grid_bloc.dart';
import 'package:schrodle/game_grid/data/tile_status.dart';
import 'package:schrodle/theme/theme.dart';

/// {@template tile}
/// Widget displaying a tile.
/// {@endtemplate}
class Tile extends StatefulWidget {
  /// {@macro tile}
  Tile({
    required this.row,
    required this.column,
    required this.flipTime,
    super.key,
  }) : flipCardController = FlipCardController();

  /// The row the tile is located in.
  final int row;

  /// The column the tile is located in.
  final int column;

  /// The time it takes a tile to flip in milliseconds.
  final int flipTime;

  /// Controls when the tile is flipped.
  late final FlipCardController flipCardController;
  
  /// Triggers the flip animation of the tile.
  void flip() => flipCardController.toggleCard();

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> with AutomaticKeepAliveClientMixin {
  /// Retrieves the [Color] for the corresponding [TileStatus].
  static Color _colorFromStatus({required TileStatus status}) {
    switch (status) {
      case TileStatus.guessed:
        return SchrodleColors.guessed;
      case TileStatus.correct:
        return SchrodleColors.correct;
      case TileStatus.present:
        return SchrodleColors.present;
      case TileStatus.absent:
        return SchrodleColors.absent;
      case TileStatus.occupied:
      case TileStatus.unoccupied:
        return SchrodleColors.unevaluated;
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    const textSize = 30.0;
    return BlocBuilder<GameGridBloc, GameGridState>(
      builder: (context, state) {
        final tile = state is GameGridInitial
            ? null
            : state.grid.at(row: widget.row, column: widget.column);
        final tileStatus = tile?.status;
        final tileLetter = tile == null ? '' : tile.letter;
        final color = tile == null
            ? SchrodleColors.unevaluated
            : _colorFromStatus(status: tile.status);
        final borderColor =
            tileStatus == null || tileStatus == TileStatus.unoccupied
                ? SchrodleColors.highlight
                : SchrodleColors.light;
        return FlipCard(
          controller: widget.flipCardController,
          flipOnTouch: false,
          direction: FlipDirection.VERTICAL,
          speed: widget.flipTime,
          front: Container(
            decoration: BoxDecoration(
              color: SchrodleColors.unevaluated,
              border: Border.all(color: borderColor),
            ),
            child: Center(
              child: Text(
                tileLetter,
                style: const TextStyle(
                  fontSize: textSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          back: ColoredBox(
            color: color,
            child: Center(
              child: Text(
                tileLetter,
                style: const TextStyle(
                  fontSize: textSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
