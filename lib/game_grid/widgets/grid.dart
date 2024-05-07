import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schrodle/dialog/dialog.dart';
import 'package:schrodle/game_grid/bloc/game_grid_bloc.dart';
import 'package:schrodle/game_grid/data/allotted_guesses.dart';
import 'package:schrodle/game_grid/widgets/tile.dart';
import 'package:schrodle/keyboard/bloc/keyboard_bloc.dart';

/// {@template grid}
/// Widget displaying the grid.
/// {@endtemplate}
class Grid extends StatelessWidget {
  /// {@macro grid}
  Grid({required bool hardMode, super.key}) {
    _numRows = hardMode ? allottedGuessesHard : allottedGuessesNormal;
    _createTiles();
  }

  /// The time it takes to flip a tile, in milliseconds.
  static const _tileFlipTime = 400;

  /// The number of columns in the grid.
  static const _numColumns = 5;

  /// The number of rows in the grid.
  late final int _numRows;

  /// The underlying representation of the grid: a 2D [Tile] matrix.
  late final List<List<Tile>> _tiles;

  /// Initializes the tiles in the grid.
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
    const gridWidth = 350.0;
    const gridHeight = 450.0;
    const tileSpacing = 5.0;
    const dialogTime = 1000;
    final gameGridProvider = BlocProvider.of<GameGridBloc>(context);
    final keyboardProvider = BlocProvider.of<KeyboardBloc>(context);
    return BlocListener<GameGridBloc, GameGridState>(
      listener: (BuildContext context, GameGridState state) async {
        if (state is GameInProgress && !keyboardProvider.isActive) {
          // Wait for game to initialize before activating the keyboard.
          keyboardProvider.add(ActivateKeyboard());
        } else if (state is RowFlipping) {
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
          final message = state.message!.replaceAll('Exception: ', '');
          dialog(context: context, message: message, displayTime: dialogTime);
        } else if (gameGridProvider.gameShouldEnd) {
          gameGridProvider.add(EndGame());
          keyboardProvider.add(DeactivateKeyboard());
        }
      },
      child: Container(
        width: gridWidth,
        constraints: const BoxConstraints(
          maxHeight: gridHeight,
        ),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _numColumns,
            crossAxisSpacing: tileSpacing,
            mainAxisSpacing: tileSpacing,
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
