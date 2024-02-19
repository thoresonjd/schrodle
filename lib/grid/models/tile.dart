import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// {@template tile}
/// Model representing a grid tile.
/// {@endtemplate}
class Tile extends Equatable {

  /// {@macro tile}
  const Tile({this.letter, this.color});

  /// The letter contained in the tile.
  final String? letter;

  /// The [Color] of the tile.
  final Color? color;

  @override
  List<Object?> get props => [letter, color];
}
