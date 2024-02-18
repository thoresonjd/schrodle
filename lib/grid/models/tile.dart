import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Tile extends Equatable {
  final String? letter;
  final Color? color;
  Tile({this.letter, this.color});

  @override
  List<Object?> get props => [letter, color];
}
