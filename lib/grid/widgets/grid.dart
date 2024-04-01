import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schrodle/dialog/dialog.dart';
import 'package:schrodle/game/bloc/game_bloc.dart';
import 'package:schrodle/grid/bloc/grid_bloc.dart';
import 'package:schrodle/grid/widgets/tile.dart';

/// {@template grid}
/// Widget displaying the grid.
/// {@endtemplate}
class Grid extends StatelessWidget {
  /// {@macro grid}
  Grid({super.key}) {
    _createTiles();
  }

  static const _numRows = 5;
  static const _numColumns = 5;
  static const _gridWidth = 500.0;
  static const _gridPadding = 50.0;
  static const _tileSpacing = 4.0;
  static const _tileFlipTime = 400;
  late final List<List<Tile>> _tiles;

  void _createTiles() {
    _tiles = List<List<Tile>>.generate(
      _numRows,
      (row) => List<Tile>.generate(
        _numColumns,
        (column) => Tile(
          row: row,
          column: column,
          flipTime: _tileFlipTime,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GridBloc, GridState>(
          listener: (BuildContext context, GridState state) async {
            if (state is GridRowFlipping) {
              for (var column = 0; column < _numColumns; column++) {
                _tiles[state.row][column].flip();
                // Half way through a tile's flip animation, the next tile
                // begins its own flip. Thus, we must wait for each tile to flip
                // half way before initiating the next flip. The final tile has
                // no successive tiles. Therefore, we wait for the final tile to
                // fully complete its flip animation before moving on.
                final sleepTime = column < _numColumns - 1
                    ? _tileFlipTime ~/ 2
                    : _tileFlipTime;
                final duration = Duration(milliseconds: sleepTime);
                await Future.delayed(duration, () => {});
              }
              if (context.mounted) {
                BlocProvider.of<GridBloc>(context).add(RowForward());
              }
            }
          },
        ),
        BlocListener<GameBloc, GameState>(
          listener: (BuildContext context, GameState state) {
            if (state is GameOver) {
              BlocProvider.of<GridBloc>(context).add(CompleteGrid());
              final message =
                  state.won ? 'YOU WON!' : state.targetWord.toUpperCase();
              dialog(
                context: context,
                message: message,
                displayTime: 2500,
              );
            }
          },
        ),
      ],
      child: SizedBox(
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
            return _tiles[row][column];
          },
        ),
      ),
    );
  }
}
