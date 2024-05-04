import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schrodle/dialog/dialog.dart';
import 'package:schrodle/game_grid/bloc/game_grid_bloc.dart';
import 'package:schrodle/game_grid/widgets/tile.dart';
import 'package:schrodle/keyboard/bloc/keyboard_bloc.dart';

/// {@template grid}
/// Widget displaying the grid.
/// {@endtemplate}
class GameGrid extends StatelessWidget {
  /// {@macro grid}
  GameGrid({required bool hardMode, super.key}) {
    _numRows = hardMode ? 13 : 7;
    _createTiles();
  }

  late final int _numRows;
  static const _numColumns = 5;
  static const _gridWidth = 350.0;
  static const _gridHeight = 600.0;
  static const _gridPadding = 25.0;
  static const _tileSpacing = 5.0;
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
    final gameGridProvider = BlocProvider.of<GameGridBloc>(context);
    final keyboardProvider = BlocProvider.of<KeyboardBloc>(context);
    return BlocListener<GameGridBloc, GameGridState>(
      listener: (BuildContext context, GameGridState state) async {
        if (state is RowFlipping) {
          keyboardProvider.add(DeactivateKeyboard());
          for (var column = 0; column < _numColumns; column++) {
            _tiles[state.row][column].flip();
            // Half way through a tile's flip animation, the next tile
            // begins its own flip. Thus, we must wait for each tile to flip
            // half way before initiating the next flip. The final tile has
            // no successive tiles. Therefore, we wait for the final tile to
            // fully complete its flip animation before moving on.
            final sleepTime =
                column < _numColumns - 1 ? _tileFlipTime ~/ 2 : _tileFlipTime;
            final duration = Duration(milliseconds: sleepTime);
            await Future.delayed(duration, () => {});
          }
          if (context.mounted) {
            gameGridProvider.add(RowForward());
            keyboardProvider.add(ActivateKeyboard());
          }
        } else if (state is GuessEvaluated && state.message != null) {
          dialog(context: context, message: state.message!, displayTime: 1000);
        } else if (gameGridProvider.gameShouldEnd) {
          gameGridProvider.add(EndGame());
          keyboardProvider.add(DeactivateKeyboard());
        }
      },
      child: Container(
        width: _gridWidth,
        constraints: BoxConstraints(maxHeight: _gridHeight),
        child: GridView.builder(
          shrinkWrap: true,
          //padding: const EdgeInsets.all(_gridPadding),
          physics: const AlwaysScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _numColumns,
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
