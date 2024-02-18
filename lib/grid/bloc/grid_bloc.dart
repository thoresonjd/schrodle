import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:schrodle/grid/models/grid.dart';
import 'package:schrodle/grid/models/tile.dart';

part 'grid_event.dart';
part 'grid_state.dart';

class GridBloc extends Bloc<GridEvent, GridState> {
  static const _numRows = 5;
  static const _numColumns = 5;
  int _row = 0;
  int _column = -1;
  late final List<List<Tile>> _tiles;

  GridBloc() : super(GridInitial(grid: Grid(tiles: List.empty()))) {
    on<LoadGrid>(_loadGrid);
    on<RowForward>(_rowForward);
    on<ColumnForward>(_columnForward);
    on<ColumnBackward>(_columnBackward);
    on<CompleteGrid>(_completeGrid);
  }

  void _initializeGrid() {
    _tiles = List<List<Tile>>.generate(
      _numRows,
      (row) => List<Tile>.generate(
        _numColumns,
        (col) => Tile(),
      ),
    );
  }

  void _loadGrid(LoadGrid event, Emitter<GridState> emit) {
    _initializeGrid();
    emit(GridIncomplete(grid: Grid(tiles: _tiles)));
  }

  void _rowForward(RowForward event, Emitter<GridState> emit) {
    if (state is GridComplete || _row >= _numRows || _column < 4) {
      return;
    }
    _row++;
    if (_row >= _numRows) {
      add(CompleteGrid());
    }
    _column = -1;
    emit(GridUpdated(grid: Grid(tiles: _tiles)));
    emit(GridIncomplete(grid: Grid(tiles: _tiles)));
  }

  void _columnForward(ColumnForward event, Emitter<GridState> emit) {
    if (state is GridComplete || _column >= _numColumns - 1) {
      return;
    }
    _column++;
    _tiles[_row][_column] = Tile(letter: event.letter);
    emit(GridUpdated(grid: Grid(tiles: _tiles)));
    emit(GridIncomplete(grid: Grid(tiles: _tiles)));
  }

  void _columnBackward(ColumnBackward event, Emitter<GridState> emit) {
    if (state is GridComplete || _column <= -1) {
      return;
    }
    _tiles[_row][_column] = Tile();
    _column--;
    emit(GridUpdated(grid: Grid(tiles: _tiles)));
    emit(GridIncomplete(grid: Grid(tiles: _tiles)));
  }

  void _completeGrid(CompleteGrid event, Emitter<GridState> emit) {
    emit(GridComplete(grid: Grid(tiles: _tiles)));
  }
}
