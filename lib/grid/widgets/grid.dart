import 'package:flutter/material.dart';
import 'package:schrodle/grid/widgets/tile.dart';

/// {@template grid}
/// Widget displaying the grid.
/// {@endtemplate}
class Grid extends StatelessWidget {

  /// {@macro grid}
  const Grid({super.key});

  static const _numRows = 5;
  static const _numColumns = 5;
  static const _gridWidth = 500.0;
  static const _gridPadding = 50.0;
  static const _tileSpacing = 4.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _gridWidth,
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(_gridPadding),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _numRows,
          crossAxisSpacing: _tileSpacing,
          mainAxisSpacing: _tileSpacing,
        ),
        itemCount: _numRows * _numColumns,
        itemBuilder: (BuildContext context, int index) {
          final row = index ~/ _numColumns;
          final column = index % _numColumns;
          return Tile(row: row, column: column);
        },
      ),
    );
  }
}
