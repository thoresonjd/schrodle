import 'package:flutter/material.dart';
import 'package:schrodle/information/widgets/example_tile.dart';

/// {@template example_row}
/// Renders an row as part of an example game grid scenario.
/// {@endtemplate}
class ExampleRow extends StatelessWidget {
  /// {@macro example_row}
  const ExampleRow({
    required this.numTiles,
    required this.tileLetters,
    required this.tileColors,
    required this.annotation,
    super.key,
  });

  /// The number of tiles in the row.
  final int numTiles;

  /// The string representing the letters of each tile in the row.
  final String tileLetters;

  /// The list of colors corresponding to each tile in the row.
  final List<Color> tileColors;

  /// The annotation explaining the row and its contents.
  final String annotation;

  @override
  Widget build(BuildContext context) {
    const tileSpacing = 2.5;
    const rowEndMargin = 7.5;
    final row = List<Widget>.generate(
      numTiles,
      (index) => Row(
        children: [
          ExampleTile(letter: tileLetters[index], color: tileColors[index]),
          const SizedBox(width: tileSpacing),
        ],
      ),
    )
      ..add(const SizedBox(width: rowEndMargin))
      ..add(Text(annotation));
    return Row(children: row);
  }
}
