/// Represents the guess status for tiles in the grid.
enum TileStatus {
  /// The tile has not been filled with a letter.
  unoccupied,

  /// The tile is occupied by a letter.
  occupied,

  /// The tile's letter is not present in the selected word.
  absent,

  /// The tile's letter is present but not in the
  /// correct location of the selected word.
  present,

  /// The tile's letter is in the correct location of the selected word. If the
  /// selected word is the impostor, and it is correctly guessed, the tile will
  /// be marked with this status.
  correct,

  /// The tile's containing row contains a guess that
  /// correctly matches the target word.
  guessed
}
