import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:schrodle/glossary/glossary.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitial()) {
    on<LoadGame>(_loadGame);
    on<GuessMade>(_guessMade);
    on<GameOver>(_gameOver);
  }

  late final Glossary _validGuesses;
  late final Glossary _validSolutions;
  late final String _targetWord;
  late final String _impostorWord;

  Future<void> _populateGlossaries() async {
    _validGuesses = await Glossary.fromFile(filePath: 'glossary/guesses');
    _validSolutions = await Glossary.fromFile(filePath: 'glossary/solutions');
  }

  void _selectWords() {
    final randomWordSelector = RandomWordSelector();
    _targetWord = randomWordSelector.select(_validSolutions);
    _impostorWord = randomWordSelector.select(_validSolutions);
  }

  bool isValidGuess(String? word) {
    if (word == null) {
      return false;
    }
    return _validGuesses.search(word) || _validSolutions.search(word);
  }

  Future<void> _loadGame(LoadGame event, Emitter<GameState> emit) async {
    await _populateGlossaries();
    _selectWords();
  }

  void _guessMade(GuessMade event, Emitter<GameState> emit) {
    // TODO: handle game over
    print(event.isValidGuess);
    emit(GameInProgress(isCurrentGuessValid: event.isValidGuess));
  }

  void _gameOver(GameOver event, Emitter<GameState> emit) {
    // TODO: implement
  }
}
