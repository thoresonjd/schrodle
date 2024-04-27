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
    const dividerSize = 2.5;
    final row = List<Widget>.generate(
      numTiles,
      (index) => Row(
        children: [
          SizedBox(
            width: tileSize,
            height: tileSize,
            child: ColoredBox(
              color: tileColors[index],
              child: Align(child: Text(tileLetters[index])),
            ),
          ),
          const VerticalDivider(width: dividerSize, color: Colors.transparent),
        ],
      ),
    )..add(Text(annotation));
    return Row(children: row);
  }
}
