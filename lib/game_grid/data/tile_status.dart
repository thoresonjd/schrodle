/// Represents the guess status for tiles in the grid.
enum TileStatus {
  /// The tile has not been filled with a guess/letter.
  unoccupied,

  /// The tile is occupied by a letter.
  occupied,

  /// The tile's letter is not present.
  absent,

  /// The tile's letter is present but not in the correct location.
  present,

  /// The tile's letter is in the correct location.
  correct,

  /// The tile's containing row has been guessed correctly.
  guessed
}
