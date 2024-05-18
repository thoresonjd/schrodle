import 'dart:math' show Random;
import 'package:schrodle/lexicon/classes/lexicon.dart';

/// {@template random_word_selector}
/// Handles random word selection.
/// {@endtemplate}
class RandomWordSelector {
  /// {@macro random_word_selector}
  RandomWordSelector({required int seed}) : _rng = Random(seed);

  /// Random number generator.
  late final Random _rng;

  /// Selects a random word from the given [lexicon].
  String select({required Lexicon lexicon}) {
    if (lexicon.isEmpty) {
      throw Exception('The provided lexicon is empty');
    }
    final max = lexicon.length;
    final index = _rng.nextInt(max);
    return lexicon[index];
  }

  /// Chooses between two provided words.
  String choose({required String first, required String second}) {
    return _rng.nextBool() ? first : second;
  }
}
