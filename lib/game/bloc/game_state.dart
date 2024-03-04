part of 'game_bloc.dart';

sealed class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

final class GameInitial extends GameState {}

final class GameInProgress extends GameState {
  GameInProgress({required this.isCurrentGuessValid});
  final bool isCurrentGuessValid;
}

final class GameWon extends GameState {}

final class GameLost extends GameState {}
