import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:schrodle/theme/classes/schrodle_colors.dart';

/// {@template example_tile}
/// Renders a tile as part of an example game grid scenario.
/// {@endtemplate}
class ExampleTile extends StatefulWidget {
  /// {@macro example_tile}
  const ExampleTile({required this.letter, required this.color, super.key});

  /// The letter contained in the tile.
  final String letter;

  /// The color of the tile.
  final Color color;

  @override
  State<ExampleTile> createState() => _ExampleTileState();
}

class _ExampleTileState extends State<ExampleTile> {
  late final FlipCardController flipCardController;

  @override
  void initState() {
    super.initState();
    flipCardController = FlipCardController();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => flipCardController.toggleCard(),
    );
  }

  @override
  Widget build(BuildContext context) {
    const tileSize = 30.0;
    const textSize = 20.0;
    const flipTime = 800;
    return FlipCard(
      controller: flipCardController,
      flipOnTouch: false,
      direction: FlipDirection.VERTICAL,
      speed: flipTime,
      front: Container(
        width: tileSize,
        height: tileSize,
        decoration: BoxDecoration(
          color: SchrodleColors.none,
          border: Border.all(color: SchrodleColors.light),
        ),
        child: Align(
          child: Text(
            widget.letter,
            style: const TextStyle(
              fontSize: textSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      back: Container(
        width: tileSize,
        height: tileSize,
        color: widget.color,
        child: Align(
          child: Text(
            widget.letter,
            style: const TextStyle(
              fontSize: textSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
