import 'dart:math' show Random;
import 'glossary.dart';

class RandomWordSelector {
  RandomWordSelector() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final seed = today.millisecondsSinceEpoch;
    this.seed(seed: seed);
  }

  late Random rng;

  void seed({required int seed}) => rng = Random(seed);

  String select(Glossary glossary) {
    if (glossary.isEmpty) {
      throw Exception('The provided glossary is empty');
    }
    final max = glossary.length;
    final index = rng.nextInt(max);
    return glossary[index];
  }
}
