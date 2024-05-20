/// {@template game_mode}
/// Enumeration denoting which game modes are available to play.
/// {@endtemplate}
enum GameMode {
  /// Normal mode.
  normal(name: 'Normal', allottedGuesses: 10),

  /// Hard mode.
  hard(name: 'Hard', allottedGuesses: 20);

  /// {@macro game_mode}
  const GameMode({required this.name, required this.allottedGuesses});

  /// The name of the game mode.
  final String name;

  /// The number of allotted guesses for the game mode.
  final int allottedGuesses;
}
