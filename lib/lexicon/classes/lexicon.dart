import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

/// {@template lexicon}
/// Encapsulates a vocabulary of known words.
/// {@endtemplate}
class Lexicon {
  /// {@macro lexicon}
  Lexicon._();

  /// The underlying representation of a [Lexicon]; a list of words.
  /// Since the lexicon files are unique, this is essentially just a set.
  /// A [List] is used in favor of a [Set] to allow for indexing. 
  late final List<String> _words;

  /// Static factory method that constructs a [Lexicon] instance and
  /// populates it from a file given a [filePath].
  /// Assumes the words are unique and sorted before read from file.
  static Future<Lexicon> fromFile({required String filePath}) async {
    final lexicon = Lexicon._();
    await lexicon._populate(filePath: filePath);
    return lexicon;
  }

  /// Populates the [Lexicon] instance from a file given a [filePath].
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

  /// Determines if the given [word] exists in the [Lexicon] instance.
  /// Since the lexicon files are sorted, a binary search is utilized.
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

  /// Determines if the lexicon is empty.
  bool get isEmpty => _words.isEmpty;

  /// Retrieves the number of words in the lexicon.
  int get length => _words.length;
}
