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
          tileLetters: 'PURGE',
          tileColors: List<Color>.generate(rowSize, (index) => Colors.red),
          annotation: 'AXIOM selected; 0 letters marked present or correct',
        ),
        const Divider(height: dividerSize, color: Colors.transparent),
        const ExampleRow(
          numTiles: rowSize,
          tileLetters: 'SONIC',
          tileColors: [
            Colors.red,
            Colors.green,
            Colors.red,
            Colors.green,
            Colors.green,
          ],
          annotation: 'LOGIC selected; 3 letters marked correct',
        ),
        const Divider(height: dividerSize, color: Colors.transparent),
        const ExampleRow(
          numTiles: rowSize,
          tileLetters: 'TOXIC',
          tileColors: [
            Colors.red,
            Colors.yellow,
            Colors.yellow,
            Colors.yellow,
            Colors.red,
          ],
          annotation:
              'AXIOM selected; 3 letters marked present',
        ),
        const Divider(height: dividerSize, color: Colors.transparent),
        ExampleRow(
          numTiles: rowSize,
          tileLetters: 'LOGIC',
          tileColors: List<Color>.generate(rowSize, (index) => Colors.green),
          annotation: 'LOGIC selected; impostor guessed',
        ),
        const Divider(height: dividerSize, color: Colors.transparent),
        ExampleRow(
          numTiles: rowSize,
          tileLetters: 'AXIOM',
          tileColors: List<Color>.generate(rowSize, (index) => Colors.blue),
          annotation: 'AXIOM selected; target guessed',
        ),
      ],
    );
  }
}
