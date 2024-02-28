import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:schrodle/grid/models/grid.dart';
import 'package:schrodle/grid/models/tile.dart';

part 'grid_event.dart';
part 'grid_state.dart';

/// {@template grid_bloc}
/// Tracks the state of the grid and manages grid event.
/// {@endtemplate}
class GridBloc extends Bloc<GridEvent, GridState> {
  /// {@macro grid_bloc}
  GridBloc() : super(GridInitial(grid: Grid(tiles: List.empty()))) {
    on<LoadGrid>(_loadGrid);
    on<RowFlip>(_rowFlip);
    on<RowForward>(_rowForward);
    on<ColumnForward>(_columnForward);
    on<ColumnBackward>(_columnBackward);
    on<CompleteGrid>(_completeGrid);
  }

  static const _numRows = 5;
  static const _numColumns = 5;
  int _row = 0;
  int _column = -1;
  late final List<List<Tile>> _tiles;

  /// Assigns a [Tile] at each intersecting row and column.
  void _initializeGrid() {
    _tiles = List<List<Tile>>.generate(
      _numRows,
      (row) => List<Tile>.generate(
        _numColumns,
        (col) => const Tile(),
      ),
    );
  }

  /// Loads the grid.
  void _loadGrid(LoadGrid event, Emitter<GridState> emit) {
    _initializeGrid();
    emit(GridIncomplete(grid: Grid(tiles: _tiles)));
  }

  /// Initiates the flipping of the current row.
  void _rowFlip(RowFlip event, Emitter<GridState> emit) {
    if (state is GridComplete ||
        _row >= _numRows ||
        _column < _numColumns - 1) {
      return;
    }
    emit(GridRowFlipping(row: _row, grid: Grid(tiles: _tiles)));
  }

  /// Moves the current [_row] of the grid forward by one.
  void _rowForward(RowForward event, Emitter<GridState> emit) {
    if (state is GridComplete ||
        _row >= _numRows ||
        _column < _numColumns - 1) {
      return;
    }
    _row++;
    if (_row >= _numRows) {
      add(CompleteGrid());
    }
    _column = -1; 
    emit(GridIncomplete(grid: Grid(tiles: _tiles)));
  }

  /// Moves the current [_column] of the grid forward by one.
  void _columnForward(ColumnForward event, Emitter<GridState> emit) {
    if (state is GridComplete || _column >= _numColumns - 1) {
      return;
    }
    _column++;
    _tiles[_row][_column] = Tile(letter: event.letter);
    emit(GridUpdated(grid: Grid(tiles: _tiles)));
    emit(GridIncomplete(grid: Grid(tiles: _tiles)));
  }

  /// Moves the current [_column] of the grid backward by one.
  void _columnBackward(ColumnBackward event, Emitter<GridState> emit) {
    if (state is GridComplete || state is GridRowFlipping ||  _column <= -1) {
      return;
    }
    _tiles[_row][_column] = const Tile();
    _column--;
    emit(GridUpdated(grid: Grid(tiles: _tiles)));
    emit(GridIncomplete(grid: Grid(tiles: _tiles)));
  }

  /// Sets the grid's state to [GridComplete].
  void _completeGrid(CompleteGrid event, Emitter<GridState> emit) {
    emit(GridComplete(grid: Grid(tiles: _tiles)));
  }
}
