/// {@template game_mode}
/// Enumeration denoting which game modes are available to play.
/// {@endtemplate}
enum GameMode {
  /// Normal mode.
  /// The target and impostor have equal (50%) probability of selection.
  normal(name: 'Normal', allottedGuesses: 10),

  /// Probabilistic mode.
  /// The probability to select the target decreases if selected and increases
  /// if not selected. The impostor has inverse probability (total 100%).
  probabilistic(name: 'Probabilistic', allottedGuesses: 10),

  /// Hard mode.
  /// A word is constructed such that each individual letter has an equal
  /// probability (50%) of selection from either target or impostor.
  hard(name: 'Hard', allottedGuesses: 20);

  /// {@macro game_mode}
  const GameMode({required this.name, required this.allottedGuesses});

  /// The name of the game mode.
  final String name;

  /// The number of allotted guesses for the game mode.
  final int allottedGuesses;
}
