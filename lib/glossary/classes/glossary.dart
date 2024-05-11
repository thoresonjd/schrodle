import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

/// {@template glossary}
/// Stores words read from a file.
/// Assumes the words are unique and sorted.
/// {@endtemplate}
class Glossary {
  /// {@macro glossary}
  Glossary._();

  /// The underlying representation of a [Glossary]; a list of words.
  /// Since the glossary files are unique, this is essentially just a set.
  late final List<String> _words;

  /// Static factory method that constructs a [Glossary] instance and
  /// populates it from a file given a [filePath].
  static Future<Glossary> fromFile({required String filePath}) async {
    final glossary = Glossary._();
    await glossary._populate(filePath: filePath);
    return glossary;
  }

  /// Populates the [Glossary] instance from a file given a [filePath].
  Future<void> _populate({required String filePath}) async {
    if (kIsWeb) {
      _words = (await rootBundle.loadString(filePath)).split(' ');
    } else {
      (await File(filePath)
              .openRead()
              .map(utf8.decode)
              .transform(const LineSplitter())
              .toList())
          .forEach(_words.add);
    }
  }

  /// Determines if the given [word] exists in the [Glossary] instance.
  /// Since the glossary files are sorted, a binary search is utilized.
  bool search({required String word}) {
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

  /// Retrieves the word at the given [index].
  String operator [](int index) => _words[index];

  /// Determines if the glossary is empty.
  bool get isEmpty => _words.isEmpty;

  /// Retrieves the number of words in the glossary.
  int get length => _words.length;
}
