import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schrodle/grid/bloc/grid_bloc.dart';

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

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GridBloc, GridState>(
      builder: (context, state) {
        late Text text;
        late Color color;
        switch (state.runtimeType) {
          case GridRowFlipping:
          case GridIncomplete:
          case GridComplete:
            final tile = state.grid.at(row: widget.row, column: widget.column);
            text = Text(tile.letter ?? '');
            color = tile.color ?? Colors.red;
          default:
            text = const Text('');
            color = Colors.red;
        }
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
