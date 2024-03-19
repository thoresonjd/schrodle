import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:schrodle/glossary/glossary.dart';
import 'package:schrodle/grid/constants/tile_status.dart';

part 'game_event.dart';
part 'game_state.dart';

/// {@template game_bloc}
/// Handles game-specific state changes and events.
/// {@endtemplate}
class GameBloc extends Bloc<GameEvent, GameState> {
  /// {@macro game_bloc}
  GameBloc() : super(GameInitial()) {
    on<LoadGame>(_loadGame);
    on<GuessMade>(_guessMade);
  }

  static const _numRows = 5;
  static const _numColumns = 5;
  int _row = 0;
  final _randomWordSelector = RandomWordSelector();
  late final Glossary _validGuesses;
  late final Glossary _validSolutions;
  late final String _targetWord;
  late final String _impostorWord;
  late final List<List<TileStatus>> _gridStatus;

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

  /// Initializes the status of each tile in the grid.
  void _initializeGridStatus() {
    _gridStatus = List<List<TileStatus>>.generate(
      _numRows,
      (row) => List<TileStatus>.generate(
        _numColumns,
        (column) => TileStatus.unanswered,
      ),
    );
  }

  /// Determines if a given [word] is a valid guess.
  bool isValidGuess(String word) {
    return _validGuesses.search(word) || _validSolutions.search(word);
  }

  /// Updates the grid status at the current row given a [guess].
  void updateGridStatus(String guess) {
    if (guess == _targetWord) {
      _gridStatus[_row] =
          List<TileStatus>.filled(_numColumns, TileStatus.guessed);
      return;
    }
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
    for (var i = 0; i < _numColumns; i++) {
      if (guess[i] == word[i]) {
        lettersLeft.remove(guess[i]);
        _gridStatus[_row][i] = TileStatus.correctSpot;
      } else {
        _gridStatus[_row][i] = TileStatus.notPresent;
      }
    }
    // Mark letters present in the incorrect spot
    for (var i = 0; i < _numColumns; i++) {
      if (_gridStatus[_row][i] != TileStatus.correctSpot &&
          lettersLeft.contains(guess[i])) {
        _gridStatus[_row][i] = TileStatus.present;
        lettersLeft.remove(guess[i]);
      }
    }
  }

  /// Checks if the target word has been guessed at the current row.
  bool _isTargetWordGuessed() {
    for (final letterStatus in _gridStatus[_row]) {
      if (letterStatus != TileStatus.guessed) {
        return false;
      }
    }
    return true;
  }

  /// Retrieves the status of the tiles in the current row.
  List<TileStatus> get currentRowStatus => _gridStatus[_row];

  /// Loads the game.
  Future<void> _loadGame(LoadGame event, Emitter<GameState> emit) async {
    await _populateGlossaries();
    _selectWords();
    _initializeGridStatus();
    emit(const GameInProgress());
  }

  /// Handles guesses as they are made.
  void _guessMade(GuessMade event, Emitter<GameState> emit) {
    if (_isTargetWordGuessed()) {
      emit(const GameOver(won: true));
      return;
    }
    _row++;
    if (_row >= _numRows) {
      emit(const GameOver(won: false));
      return;
    }
    emit(const GameInProgress());
  }
}
