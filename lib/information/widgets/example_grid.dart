import 'package:flutter/material.dart';
import 'package:schrodle/information/widgets/example_row.dart';
import 'package:schrodle/theme/theme.dart';

class ExampleGrid extends StatelessWidget {
  const ExampleGrid({super.key});

  @override
  Widget build(BuildContext context) {
    const rowSize = 5;
    const dividerSize = 2.5;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExampleRow(
            numTiles: rowSize,
            tileLetters: 'PURGE',
            tileColors: List<Color>.generate(rowSize, (index) => AppColors.absent),
            annotation: 'AXIOM selected; 0 letters marked present or correct',
          ),
          const Divider(height: dividerSize, color: Colors.transparent),
          const ExampleRow(
            numTiles: rowSize,
            tileLetters: 'SONIC',
            tileColors: [
              AppColors.absent,
              AppColors.correct,
              AppColors.absent,
              AppColors.correct,
              AppColors.correct,
            ],
            annotation: 'LOGIC selected; 3 letters marked correct',
          ),
          const Divider(height: dividerSize, color: Colors.transparent),
          const ExampleRow(
            numTiles: rowSize,
            tileLetters: 'TOXIC',
            tileColors: [
              AppColors.absent,
              AppColors.present,
              AppColors.present,
              AppColors.present,
              AppColors.absent
            ],
            annotation:
                'AXIOM selected; 3 letters marked present',
          ),
          const Divider(height: dividerSize, color: Colors.transparent),
          ExampleRow(
            numTiles: rowSize,
            tileLetters: 'LOGIC',
            tileColors: List<Color>.generate(rowSize, (index) => AppColors.correct),
            annotation: 'LOGIC selected; impostor guessed',
          ),
          const Divider(height: dividerSize, color: Colors.transparent),
          ExampleRow(
            numTiles: rowSize,
            tileLetters: 'AXIOM',
            tileColors: List<Color>.generate(rowSize, (index) => AppColors.guessed),
            annotation: 'AXIOM selected; target guessed',
          ),
        ],
      ),
    );  
  }
}
