import 'package:flutter/material.dart';
import 'package:schrodle/information/widgets/example_row.dart';
import 'package:schrodle/theme/theme.dart';

/// {@template example_grid}
/// Renders an example game grid scenario.
/// {@endtemplate}
class ExampleGrid extends StatelessWidget {
  /// {@macro example_grid}
  const ExampleGrid({super.key});

  @override
  Widget build(BuildContext context) {
    const rowSize = 5;
    const dividerSize = 2.5;
    final scrollController = ScrollController();
    return Scrollbar(
      thumbVisibility: true,
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExampleRow(
              numTiles: rowSize,
              tileLetters: 'PURGE',
              tileColors: List<Color>.generate(rowSize, (index) =>
                SchrodleColors.absent,),
              annotation: 'AXIOM selected; 0 letters marked present or correct',
            ),
            const Divider(height: dividerSize, color: Colors.transparent),
            const ExampleRow(
              numTiles: rowSize,
              tileLetters: 'SONIC',
              tileColors: [
                SchrodleColors.absent,
                SchrodleColors.correct,
                SchrodleColors.absent,
                SchrodleColors.correct,
                SchrodleColors.correct,
              ],
              annotation: 'LOGIC selected; 3 letters marked correct',
            ),
            const Divider(height: dividerSize, color: Colors.transparent),
            const ExampleRow(
              numTiles: rowSize,
              tileLetters: 'TOXIC',
              tileColors: [
                SchrodleColors.absent,
                SchrodleColors.present,
                SchrodleColors.present,
                SchrodleColors.present,
                SchrodleColors.absent,
              ],
              annotation: 'AXIOM selected; 3 letters marked present',
            ),
            const Divider(height: dividerSize, color: Colors.transparent),
            ExampleRow(
              numTiles: rowSize,
              tileLetters: 'LOGIC',
              tileColors:
                  List<Color>.generate(rowSize, (index) => 
                    SchrodleColors.correct,),
              annotation: 'LOGIC selected; impostor guessed',
            ),
            const Divider(height: dividerSize, color: Colors.transparent),
            ExampleRow(
              numTiles: rowSize,
              tileLetters: 'AXIOM',
              tileColors:
                  List<Color>.generate(rowSize, (index) => 
                    SchrodleColors.guessed,),
              annotation: 'AXIOM selected; target guessed',
            ),
          ],
        ),
      ),
    );
  }
}
