import 'package:flutter/material.dart';

class ExampleRow extends StatelessWidget {
  const ExampleRow({super.key, required this.numTiles, required this.tileColors, required this.tileLetters});

  final int numTiles;
  final List<Color> tileColors;
  final List<String> tileLetters;

  @override
  Widget build(BuildContext context) {
    const tileSize = 50.0;
    const dividerSize = 2.5;
    return Row(
      children: List<Widget>.generate(numTiles, (index) => Row(children: [
        SizedBox(
          width: tileSize,
          height: tileSize,
          child: ColoredBox(
            color: tileColors[index],
            child: Align(child: Text(tileLetters[index])),
          ),
        ),
        const VerticalDivider(width: dividerSize, color: Colors.transparent),
      ],),),
    );
  }
}
