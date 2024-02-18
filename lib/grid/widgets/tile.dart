import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schrodle/grid/bloc/grid_bloc.dart';

class Tile extends StatefulWidget {
  Tile({super.key, required this.row, required this.column})
      : flipCardController = FlipCardController();

  static const flipSpeed = 400;
  late final FlipCardController flipCardController;
  final int row;
  final int column;

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GridBloc, GridState>(
      builder: (context, state) {
        late Text text;
        switch (state.runtimeType) {
          case GridIncomplete:
          case GridComplete:
            final letter =
                state.grid.letterAt(row: widget.row, column: widget.column);
            text = Text(letter ?? '');
            break;
          default:
            text = const Text('');
        }
        return GestureDetector(
          onTap: widget.flipCardController.toggleCard,
          child: FlipCard(
            controller: widget.flipCardController,
            flipOnTouch: false,
            direction: FlipDirection.VERTICAL,
            speed: Tile.flipSpeed,
            front: ColoredBox(
              color: Colors.red,
              child: Center(
                child: text,
              ),
            ),
            back: ColoredBox(
              color: Colors.orange,
              child: Center(
                child: text,
              ),
            ),
          ),
        );
      },
    );
  }
}
