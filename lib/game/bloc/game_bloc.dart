import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:schrodle/glossary/glossary.dart';
import 'package:schrodle/grid/constants/letter_status.dart';

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
    on<GameOver>(_gameOver);
  }

  static const _numRows = 5;
  static const _numColumns = 5;
  int _row = 0;
  final _randomWordSelector = RandomWordSelector();
  late final Glossary _validGuesses;
  late final Glossary _validSolutions;
  late final String _targetWord;
  late final String _impostorWord;
  late final List<List<LetterStatus>> _gridStatus;

  /// Populates two [Glossary] instances with valid solutions and guesses.
  Future<void> _populateGlossaries() async {
    _validGuesses = await Glossary.fromFile(filePath: 'glossary/guesses');
    _validSolutions = await Glossary.fromFile(filePath: 'glossary/solutions');
  }

  /// Selects both the [_targetWord] and the [_impostorWord].
  void _selectWords() {
    _targetWord = _randomWordSelector.select(_validSolutions);
    _impostorWord = _randomWordSelector.select(_validSolutions);
    print(_targetWord);
    print(_impostorWord);
  }

  /// TODO: document
  void _initializeGridStatus() {
    _gridStatus = List<List<LetterStatus>>.generate(
      _numRows,
      (row) => List<LetterStatus>.generate(
        _numColumns,
        (column) => LetterStatus.unanswered,
      ),
    );
  }

  /// Determines if a given [word] is a valid guess.
  bool isValidGuess(String word) {
    return _validGuesses.search(word) || _validSolutions.search(word);
  }

  void updateGridStatus(String guess) {
    if (guess == _targetWord) {
      _gridStatus[_row] =
          List<LetterStatus>.filled(_numColumns, LetterStatus.guessed);
      return;
    }
    // TODO: check against impostor word too
    final word = _targetWord;
    final lettersLeft = word.characters.toList();
    // Mark letters in correct spot first
    for (var i = 0; i < _numColumns; i++) {
      if (guess[i] == word[i]) {
        lettersLeft.remove(guess[i]);
        _gridStatus[_row][i] = LetterStatus.correctSpot;
      } else {
        _gridStatus[_row][i] = LetterStatus.notPresent;
      }
    }
    // Mark letters present in the incorrect spot
    for (var i = 0; i < _numColumns; i++) {
      if (_gridStatus[_row][i] != LetterStatus.correctSpot &&
          lettersLeft.contains(guess[i])) {
        _gridStatus[_row][i] = LetterStatus.present;
        lettersLeft.remove(guess[i]);
      }
    }
  }

  /// TODO: document
  bool _targetWordGuessed() {
    for (final letterStatus in _gridStatus[_row]) {
      if (letterStatus != LetterStatus.guessed) {
        return false;
      }
    }
    return true;
  }

  List<LetterStatus> get currentRowStatus => _gridStatus[_row];

  /// Loads the game.
  Future<void> _loadGame(LoadGame event, Emitter<GameState> emit) async {
    await _populateGlossaries();
    _selectWords();
    _initializeGridStatus();
    emit(const GameInProgress());
  }

  /// Handles guesses as they are made.
  void _guessMade(GuessMade event, Emitter<GameState> emit) {
    if (_targetWordGuessed()) {
      emit(GameWon());
      return;
    }
    _row++;
    if (_row >= _numRows) {
      emit(GameLost());
      return;
    }
    emit(const GameInProgress());
  }

  /// Handles when the game completed.
  void _gameOver(GameOver event, Emitter<GameState> emit) {
    // TODO: implement
  }
}
