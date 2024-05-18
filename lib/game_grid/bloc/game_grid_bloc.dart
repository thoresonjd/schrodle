import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:schrodle/game_grid/data/allotted_guesses.dart';
import 'package:schrodle/game_grid/data/game_url.dart';
import 'package:schrodle/game_grid/data/tile_status.dart';
import 'package:schrodle/game_grid/data/tile_status_characters.dart';
import 'package:schrodle/game_grid/models/grid.dart';
import 'package:schrodle/game_grid/models/tile.dart';
import 'package:schrodle/lexicon/lexicon.dart';

part 'game_grid_event.dart';
part 'game_grid_state.dart';

/// {@template game_grid_bloc}
/// Tracks the state of the game and manages grid events.
/// {@endtemplate}
class GameGridBloc extends Bloc<GameGridEvent, GameGridState> {
  /// {@macro game_grid_bloc}
  GameGridBloc() : super(GameGridInitial(grid: Grid(tiles: List.empty()))) {
    on<LoadGrid>(_loadGrid);
    on<GuessMade>(_guessMade);
    on<RowFlip>(_rowFlip);
    on<RowForward>(_rowForward);
    on<ColumnForward>(_columnForward);
    on<ColumnBackward>(_columnBackward);
    on<EndGame>(_endGame);
  }

  /// The number of columns in the grid.
  static const int _numColumns = 5;

  /// The number of rows in the grid.
  late final int _numRows;

  /// The underlying representation of the grid: a 2D [Tile] matrix.
  late final List<List<Tile>> _tiles;

  /// Selects random words from those given.
  late final RandomWordSelector _randomWordSelector;

  /// The vocabulary of all valid guesses.
  late final Lexicon _validGuesses;

  /// The vocabulary of all valid solutions.
  late final Lexicon _validSolutions;

  /// The target word.
  late final String _target;

  /// The impostor word.
  late final String _impostor;

  /// The date of the current Schrodle game.
  late final DateTime _today;

  /// Whether the game should be played in normal mode or hard mode.
  late final bool _hardMode;

  /// The current row to track in the grid.
  int _row = 0;

  /// The current column to track in the grid.
  int _column = -1;

  /// Indicates that [_target] has been guessed.
  bool _targetGuessed = false;

  /// Indicates that [_impostor] has been guessed.
  bool _impostorGuessed = false;

  /// Indicates that the game state should transition to [GameOver].
  bool get gameShouldEnd => _targetGuessed || _row > _numRows;

  /// Populates two [Lexicon] instances with valid solutions and guesses.
  Future<void> _populateLexicons() async {
    _validGuesses =
        await Lexicon.fromFile(filePath: 'assets/lexicon/guesses');
    _validSolutions =
        await Lexicon.fromFile(filePath: 'assets/lexicon/solutions');
  }

  /// Retrieves the current date.
  DateTime get _date {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Selects both the [_target] and the [_impostor].
  void _selectWords() {
    _target =
        _randomWordSelector.select(lexicon: _validSolutions).toUpperCase();
    _impostor =
        _randomWordSelector.select(lexicon: _validSolutions).toUpperCase();
  }

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

  /// Loads the grid.
  Future<void> _loadGrid(LoadGrid event, Emitter<GameGridState> emit) async {
    await _populateLexicons();
    _hardMode = event.hardMode;
    _numRows = _hardMode ? allottedGuessesHard : allottedGuessesNormal;
    _today = _date;
    _randomWordSelector =
        RandomWordSelector(seed: _today.millisecondsSinceEpoch);
    _selectWords();
    _initializeGrid();
    emit(GameInProgress(grid: Grid(tiles: _tiles)));
  }

  /// Determines if a given [word] is a valid guess.
  bool _isValidGuess(String word) {
    final asLower = word.toLowerCase();
    return _validGuesses.search(word: asLower) ||
        _validSolutions.search(word: asLower);
  }

  /// Builds and retrieves the current guess made.
  String get _guess {
    final buffer = StringBuffer();
    for (final tile in _tiles[_row]) {
      if (tile.status == TileStatus.unoccupied) {
        throw Exception('Not enough letters');
      }
      buffer.write(tile.letter);
    }
    final guess = buffer.toString();
    if (!_isValidGuess(guess)) {
      throw Exception('Invalid guess');
    }
    return guess;
  }

  /// Checks if [_target] has been guessed.
  bool _isTarget(String word) => word == _target;

  /// Checks if [_impostor] has been guessed.
  bool _isImpostor(String word) => word == _impostor;

  /// Updates the grid status at the current row given a [guess].
  void _updateGridStatus(String guess) {
    if (_isTarget(guess)) {
      for (var column = 0; column < _numColumns; column++) {
        _tiles[_row][column] = Tile(
          status: TileStatus.guessed,
          letter: _tiles[_row][column].letter,
        );
      }
      return;
    }
    late final String word;
    if (_hardMode) {
      // Hard mode:
      // Build the word to check against where each individual letter has a
      // fifty percentchance of being derived from either the target word or
      // the impostor word.
      final buffer = StringBuffer();
      for (var i = 0; i < _numColumns; i++) {
        final choice =
            _randomWordSelector.choose(first: _target, second: _impostor);
        buffer.write(choice[i]);
      }
      word = buffer.toString();
    } else if (_isImpostor(guess)) {
      // Normal mode:
      // It may make it easier for the player to know if they have guessed the
      // impostor word. We can try this instead of relying on a 50/50 chance of
      // the impostor word being selected when correctly guessed.
      word = _impostor;
      _impostorGuessed = true;
    } else if (_impostorGuessed) {
      // Normal mode:
      // We can also prevent the impostor word from being selected again once
      // guessed for the first time.
      word = _target;
    } else {
      // Normal mode:
      // Randomly select between target and impostor words for each guess.
      word = _randomWordSelector.choose(first: _target, second: _impostor);
    }
    final lettersLeft = word.characters.toList();
    // Mark letters in correct spot first
    for (var column = 0; column < _numColumns; column++) {
      final tile = _tiles[_row][column];
      if (guess[column] == word[column]) {
        lettersLeft.remove(guess[column]);
        _tiles[_row][column] =
            Tile(status: TileStatus.correct, letter: tile.letter);
      } else {
        _tiles[_row][column] =
            Tile(status: TileStatus.absent, letter: tile.letter);
      }
    }
    // Mark letters present in the incorrect spot
    for (var i = 0; i < _numColumns; i++) {
      if (_tiles[_row][i].status != TileStatus.correct &&
          lettersLeft.contains(guess[i])) {
        _tiles[_row][i] =
            Tile(status: TileStatus.present, letter: _tiles[_row][i].letter);
        lettersLeft.remove(guess[i]);
      }
    }
  }

  /// Checks if the current row would constitute the final guess when filled.
  bool _isFinalGuess() => _row == _numRows - 1;

  /// Handles guesses as they are made.
  void _guessMade(GuessMade event, Emitter<GameGridState> emit) {
    late final String guess;
    try {
      guess = _guess;
    } on Exception catch (e) {
      emit(GuessEvaluated(grid: Grid(tiles: _tiles), message: e.toString()));
      return;
    }
    _updateGridStatus(guess);
    if (_isTarget(guess)) {
      _targetGuessed = true;
      emit(GuessEvaluated(grid: Grid(tiles: _tiles), message: 'Yay!'));
    } else if (_isFinalGuess()) {
      emit(GuessEvaluated(grid: Grid(tiles: _tiles), message: _target));
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

  /// Retrieves the results of the completed game as a [String].
  String get results {
    final date = _today.toString().split(' ')[0];
    final buffer = StringBuffer()
      ..writeln('Schrodle')
      ..writeln('Date: $date')
      ..writeln('Mode: ${_hardMode ? 'Hard' : 'Normal'}')
      ..writeln('Score: ${_targetGuessed ? _row : 'X'}/$_numRows')
      ..writeln(gameUrl);
    for (var row = 0; row < _row; row++) {
      for (final column in _tiles[row]) {
        buffer.write(tileStatusCharacters[column.status]);
      }
      buffer.writeln();
    }
    return buffer.toString();
  }
}
