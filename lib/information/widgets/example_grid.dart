import 'package:flutter/material.dart';
import 'package:schrodle/information/widgets/example_row.dart';

class ExampleGrid extends StatelessWidget {
  const ExampleGrid({super.key});

  @override
  Widget build(BuildContext context) {
    const rowSize = 5;
    const dividerSize = 2.5;
    return Column(
      children: [
        ExampleRow(
          numTiles: rowSize,
          tileColors: List<Color>.generate(rowSize, (index) => Colors.red),
          tileLetters: List<String>.generate(rowSize, (index) => 'a'),
        ),
        const Divider(height: dividerSize, color: Colors.transparent),
        ExampleRow(
          numTiles: rowSize,
          tileColors: List<Color>.generate(rowSize, (index) => Colors.red),
          tileLetters: List<String>.generate(rowSize, (index) => 'a'),
        ),
        const Divider(height: dividerSize, color: Colors.transparent),
        ExampleRow(
          numTiles: rowSize,
          tileColors: List<Color>.generate(rowSize, (index) => Colors.red),
          tileLetters: List<String>.generate(rowSize, (index) => 'a'),
        ),
        const Divider(height: dividerSize, color: Colors.transparent),
        ExampleRow(
          numTiles: rowSize,
          tileColors: List<Color>.generate(rowSize, (index) => Colors.red),
          tileLetters: List<String>.generate(rowSize, (index) => 'a'),
        ),
      ],
    );
  }
}
