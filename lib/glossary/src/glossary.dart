import 'dart:convert';
import 'dart:io';

class Glossary {
  /// private constructor
  Glossary._();

  late final List<String> _words;

  /// static factory to construct a [Glossary] instance from a file
  static Future<Glossary> fromFile({required String filePath}) async {
    final glossary = Glossary._();
    await glossary._populate(filePath: filePath);
    return glossary;
  }

  Future<void> _populate({required String filePath}) async {
    _words = List<String>.empty(growable: true);
    (await File(filePath)
            .openRead()
            .map(utf8.decode)
            .transform(const LineSplitter())
            .toList())
        .forEach(_words.add);
  }

  /// assumes file is sorted
  bool search(String word) {
    if (_words.isEmpty) {
      return false;
    }
    var left = 0;
    var right = _words.length - 1;
    while (left <= right) {
      final middle = ((right - left) ~/ 2) + left;
      final current = _words[middle];
      final comparison = word.compareTo(current);
      if (comparison == 0) {
        return true;
      }
      if (comparison < 0) {
        right = middle - 1;
      } else if (comparison > 0) {
        left = middle + 1;
      }
    }
    return false;
  }

  String operator [](int index) => _words[index];

  bool get isEmpty => _words.isEmpty;

  int get length => _words.length;
}
