import 'dart:math' show Random;
import 'package:schrodle/glossary/classes/glossary.dart';

/// {@template random_word_selector}
/// Handles random word selection from a [Glossary].
/// {@endtemplate}
class RandomWordSelector {
  /// {@macro random_word_selector}
  RandomWordSelector({required int seed}): _rng = Random(seed);

  /// Random number generator.
  late final Random _rng;

  /// Selects a random word from the given [glossary].
  String select(Glossary glossary) {
    if (glossary.isEmpty) {
      throw Exception('The provided glossary is empty');
    }
    final max = glossary.length;
    final index = _rng.nextInt(max);
    return glossary[index];
  }

  /// Chooses between two provided words
  String choose(String first, String second) {
    return _rng.nextBool() ? first : second;
  }
}
