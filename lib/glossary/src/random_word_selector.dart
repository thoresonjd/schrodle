import 'dart:math' show Random;
import 'package:schrodle/glossary/src/glossary.dart';

/// {@template random_word_selector}
/// Handles random word selection from a [Glossary].
/// {@endtemplate}
class RandomWordSelector {
  /// {@macro random_word_selector}
  RandomWordSelector() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final seed = today.millisecondsSinceEpoch;
    this.seed(seed: seed);
  }

  late Random _rng;

  /// Initializes the random number generator via a [seed].
  void seed({required int seed}) => _rng = Random(seed);

  /// Selects a random word from the given [glossary].
  String select(Glossary glossary) {
    if (glossary.isEmpty) {
      throw Exception('The provided glossary is empty');
    }
    final max = glossary.length;
    final index = _rng.nextInt(max);
    return glossary[index];
  }
}
