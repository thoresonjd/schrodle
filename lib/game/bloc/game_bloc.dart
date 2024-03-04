import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:schrodle/glossary/glossary.dart';

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
    final randomWordSelector = RandomWordSelector();
    _targetWord = randomWordSelector.select(_validSolutions);
    _impostorWord = randomWordSelector.select(_validSolutions);
  }

  /// Determines if a given [word] is a valid guess.
  bool isValidGuess(String word) {
    return _validGuesses.search(word) || _validSolutions.search(word);
  }

  /// Loads the game.
  Future<void> _loadGame(LoadGame event, Emitter<GameState> emit) async {
    await _populateGlossaries();
    _selectWords();
    emit(const GameInProgress(isCurrentGuessValid: true));
  }

  /// Handles guesses as they are made.
  void _guessMade(GuessMade event, Emitter<GameState> emit) {
    // TODO: handle game over
    print(event.isValidGuess);
    emit(GameInProgress(isCurrentGuessValid: event.isValidGuess));
  }

  /// Handles when the game completed.
  void _gameOver(GameOver event, Emitter<GameState> emit) {
    // TODO: implement
  }
}
