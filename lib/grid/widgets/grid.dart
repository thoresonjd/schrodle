import 'package:flutter/material.dart';
import 'package:schrodle/grid/widgets/tile.dart';

class Grid extends StatelessWidget {
  Grid({super.key}) {
    _createTiles();
  }

  static const _numRows = 5;
  static const _numCols = 5;
  static const _gridWidth = 500.0;
  static const _gridPadding = 50.0;
  static const _tileSpacing = 4.0;
  late final List<List<TileWidget>> _tiles;

  void _createTiles() {
    _tiles = List.generate(
      _numRows,
      (row) => List.generate(
        _numCols,
        (col) => TileWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _gridWidth,
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(_gridPadding),
        //physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _numRows,
          crossAxisSpacing: _tileSpacing,
          mainAxisSpacing: _tileSpacing,
        ),
        itemCount: _numRows * _numCols,
        itemBuilder: (BuildContext context, int index) {
          final row = index ~/ _numCols;
          final col = index % _numCols;
          return _tiles[row][col];
        },
      ),
    );
  }
}
