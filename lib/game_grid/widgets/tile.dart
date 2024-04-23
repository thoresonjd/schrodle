import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schrodle/game_grid/bloc/game_grid_bloc.dart';
import 'package:schrodle/game_grid/constants/tile_status.dart';

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

  /// Controls when the tile is flipped.
  late final FlipCardController flipCardController;

  /// The time it takes a tile to flip in milliseconds.
  final int flipTime;

  /// The row the tile is located in.
  final int row;

  /// The column the tile is located in.
  final int column;

  /// Triggers the flip animation of the tile.
  void flip() => flipCardController.toggleCard();

  /// Retrieves the [Color] for the corresponding [TileStatus].
  static Color colorFromStatus({required TileStatus status}) {
    switch (status) {
      case TileStatus.guessed:
        return Colors.blue;
      case TileStatus.correctSpot:
        return Colors.green;
      case TileStatus.present:
        return Colors.yellow;
      case TileStatus.notPresent:
      case TileStatus.occupied:
      case TileStatus.unoccupied:
        return Colors.red;
    }
  }

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameGridBloc, GameGridState>(
      builder: (context, state) {
        final tile = state is GridInitial
            ? null
            : state.grid.at(row: widget.row, column: widget.column);
        final text = Text(tile == null ? '' : tile.letter);
        final color = tile == null
            ? Colors.red
            : Tile.colorFromStatus(status: tile.status);
        return FlipCard(
          controller: widget.flipCardController,
          flipOnTouch: false,
          direction: FlipDirection.VERTICAL,
          speed: widget.flipTime,
          front: ColoredBox(
            color: Colors.red,
            child: Center(
              child: text,
            ),
          ),
          back: ColoredBox(
            color: color,
            child: Center(
              child: text,
            ),
          ),
        );
      },
    );
  }
}
