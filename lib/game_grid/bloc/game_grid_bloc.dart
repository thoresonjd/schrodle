import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:schrodle/game_grid/constants/tile_status.dart';
import 'package:schrodle/game_grid/models/grid.dart';
import 'package:schrodle/game_grid/models/tile.dart';
import 'package:schrodle/glossary/glossary.dart';

part 'game_grid_event.dart';
part 'game_grid_state.dart';

/// {@template grid_bloc}
/// Tracks the state of the grid and manages grid events.
/// {@endtemplate}
class GameGridBloc extends Bloc<GameGridEvent, GameGridState> {
  /// {@macro grid_bloc}
  GameGridBloc() : super(GridInitial(grid: Grid(tiles: List.empty()))) {
    on<LoadGrid>(_loadGrid);
    on<GuessMade>(_guessMade);
    on<RowFlip>(_rowFlip);
    on<RowForward>(_rowForward);
    on<ColumnForward>(_columnForward);
    on<ColumnBackward>(_columnBackward);
    on<EndGame>(_endGame);
  }

  static const _numRows = 5;
  static const _numColumns = 5;
  int _row = 0;
  int _column = -1;
  bool gameShouldEnd = false;
  late final List<List<Tile>> _tiles;
  final _randomWordSelector = RandomWordSelector();
  late final Glossary _validGuesses;
  late final Glossary _validSolutions;
  late final String _targetWord;
  late final String _impostorWord;

  /// Populates two [Glossary] instances with valid solutions and guesses.
  Future<void> _populateGlossaries() async {
    _validGuesses = await Glossary.fromFile(filePath: 'glossary/guesses');
    _validSolutions = await Glossary.fromFile(filePath: 'glossary/solutions');
  }

  /// Selects both the [_targetWord] and the [_impostorWord].
  void _selectWords() {
    _targetWord = _randomWordSelector.select(_validSolutions);
    _impostorWord = _randomWordSelector.select(_validSolutions);
  }

  /// Determines if a given [word] is a valid guess.
  bool _isValidGuess(String word) =>
      _validGuesses.search(word) || _validSolutions.search(word);

  /// Updates the grid status at the current row given a [guess].
  void _updateGridStatus(String guess) {
    if (guess == _targetWord) {
      for (var column = 0; column < _numColumns; column++) {
        _tiles[_row][column] = Tile(
            status: TileStatus.guessed, letter: _tiles[_row][column].letter);
      }
      return;
    }
    // It may make it easier for the player to know if they have guessed the
    // impostor word. We can try this instead of relying on a 50/50 chance of
    // the impostor word being selected when correctly guessed.
    // if (guess == _impostorWord) {
    //   for (var column = 0; column < _numColumns; column++) {
    //     _tiles[_row][column].status = TileStatus.correctSpot;
    //   }
    //   return;
    // }
    // Build word to check against where each letter has a fifty percent chance
    // of being derived from either the target word or the impostor word.
    // final buffer = StringBuffer();
    // for (var i = 0; i < _numColumns; i++) {
    //   final choice = _randomWordSelector.choose(_targetWord, _impostorWord);
    //   buffer.write(choice[i]);
    // }
    // final word = buffer.toString();
    /// We can also make it easier by randomly selecting between target and
    /// impostor words entirely instead of letter-by-letter.
    final word = _randomWordSelector.choose(_targetWord, _impostorWord);
    final lettersLeft = word.characters.toList();
    // Mark letters in correct spot first
    for (var column = 0; column < _numColumns; column++) {
      final tile = _tiles[_row][column];
      if (guess[column] == word[column]) {
        lettersLeft.remove(guess[column]);
        _tiles[_row][column] =
            Tile(status: TileStatus.correctSpot, letter: tile.letter);
      } else {
        _tiles[_row][column] =
            Tile(status: TileStatus.notPresent, letter: tile.letter);
      }
    }
    // Mark letters present in the incorrect spot
    for (var i = 0; i < _numColumns; i++) {
      if (_tiles[_row][i].status != TileStatus.correctSpot &&
          lettersLeft.contains(guess[i])) {
        _tiles[_row][i] =
            Tile(status: TileStatus.present, letter: _tiles[_row][i].letter);
        lettersLeft.remove(guess[i]);
      }
    }
  }

  /// Checks if the target word has been guessed at the current row.
  bool _isTargetWord(String word) => word == _targetWord;

  /// Checks if the current row would constitute the final guess when filled.
  bool _isFinalGuess() => _row == _numRows - 1;

  /// Assigns a [Tile] at each intersecting row and column.
  void _initializeGrid() {
    _tiles = List<List<Tile>>.generate(
      _numRows,
      (row) => List<Tile>.generate(
        _numColumns,
        (col) => const Tile(status: TileStatus.unoccupied),
      ),
    );
  }

  String _buildGuess() {
    final buffer = StringBuffer();
    for (final tile in _tiles[_row]) {
      if (tile.status == TileStatus.unoccupied) {
        throw Exception('Not enough letters');
      }
      buffer.write(tile.letter);
    }
    final guess = buffer.toString().toLowerCase();
    if (!_isValidGuess(guess)) {
      throw Exception('Invalid guess');
    }
    return guess;
  }

  /// Loads the grid.
  Future<void> _loadGrid(LoadGrid event, Emitter<GameGridState> emit) async {
    await _populateGlossaries();
    _selectWords();
    _initializeGrid();
    emit(GameInProgress(grid: Grid(tiles: _tiles)));
  }

  /// Handles guesses as they are made.
  void _guessMade(GuessMade event, Emitter<GameGridState> emit) {
    late final String guess;
    try {
      guess = _buildGuess();
    } on Exception catch (e) {
      emit(GuessEvaluated(grid: Grid(tiles: _tiles), message: e.toString()));
      return;
    }
    _updateGridStatus(guess);
    if (_isTargetWord(guess)) {
      gameShouldEnd = true;
      emit(GuessEvaluated(grid: Grid(tiles: _tiles), message: 'Yay!'));
    } else if (_isFinalGuess()) {
      emit(GuessEvaluated(grid: Grid(tiles: _tiles), message: _targetWord));
    } else {
      emit(GuessEvaluated(grid: Grid(tiles: _tiles)));
    }
    add(RowFlip());
  }

  /// Initiates the flipping of the current row.
  void _rowFlip(RowFlip event, Emitter<GameGridState> emit) {
    if (state is GameOver || _row >= _numRows || _column < _numColumns - 1) {
      return;
    }
    emit(RowFlipping(row: _row, grid: Grid(tiles: _tiles)));
  }

  /// Moves the current [_row] of the grid forward by one.
  void _rowForward(RowForward event, Emitter<GameGridState> emit) {
    if (state is GameOver || _row >= _numRows || _column < _numColumns - 1) {
      return;
    }
    _row++;
    if (_row >= _numRows) {
      add(EndGame());
    }
    _column = -1;
    emit(GameInProgress(grid: Grid(tiles: _tiles)));
  }

  /// Moves the current [_column] of the grid forward by one.
  void _columnForward(ColumnForward event, Emitter<GameGridState> emit) {
    if (state is GameOver || _column >= _numColumns - 1) {
      return;
    }
    _column++;
    _tiles[_row][_column] =
        Tile(status: TileStatus.occupied, letter: event.letter);
    emit(GridUpdated(grid: Grid(tiles: _tiles)));
    emit(GameInProgress(grid: Grid(tiles: _tiles)));
  }

  /// Moves the current [_column] of the grid backward by one.
  void _columnBackward(ColumnBackward event, Emitter<GameGridState> emit) {
    if (state is GameOver || state is RowFlipping || _column <= -1) {
      return;
    }
    _tiles[_row][_column] = const Tile(status: TileStatus.unoccupied);
    _column--;
    emit(GridUpdated(grid: Grid(tiles: _tiles)));
    emit(GameInProgress(grid: Grid(tiles: _tiles)));
  }

  /// Ends the game.
  void _endGame(EndGame event, Emitter<GameGridState> emit) {
    emit(GameOver(grid: Grid(tiles: _tiles)));
  }
}
