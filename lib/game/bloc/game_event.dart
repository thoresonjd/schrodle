part of 'game_bloc.dart';

sealed class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class LoadGame extends GameEvent {}

class GuessMade extends GameEvent {
  const GuessMade({required this.guess, required this.isValidGuess});
  final String guess;
  final bool isValidGuess;
}

class GameOver extends GameEvent {}
