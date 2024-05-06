import 'package:flutter/material.dart';

class ExampleRow extends StatelessWidget {
  const ExampleRow(
      {super.key,
      required this.numTiles,
      required this.tileLetters,
      required this.tileColors,
      required this.annotation});

  final int numTiles;
  final String tileLetters;
  final List<Color> tileColors;
  final String annotation;

  @override
  Widget build(BuildContext context) {
    const tileSize = 30.0;
    const tileSpacing = 2.5;
    const rowEndMargin = 7.5;
    const textSize = 20.0;
    final row = List<Widget>.generate(
      numTiles,
      (index) => Row(
        children: [
          SizedBox(
            width: tileSize,
            height: tileSize,
            child: ColoredBox(
              color: tileColors[index],
              child: Align(
                child: Text(
                  tileLetters[index],
                  style: const TextStyle(
                    fontSize: textSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: tileSpacing),
        ],
      ),
    )
      ..add(const SizedBox(width: rowEndMargin))
      ..add(Text(annotation));
    return Row(children: row);
  }
}
