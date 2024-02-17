import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  TileWidget({super.key}) : _flipCardController = FlipCardController();

  static const _flipSpeed = 400;
  late final FlipCardController _flipCardController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCardController.toggleCard,
      child: FlipCard(
        controller: _flipCardController,
        flipOnTouch: false,
        direction: FlipDirection.VERTICAL,
        speed: _flipSpeed,
        front: const ColoredBox(
          color: Colors.red,
          child: Center(
            child: Text('Front'),
          ),
        ),
        back: const ColoredBox(
          color: Colors.orange,
          child: Center(
            child: Text('Back'),
          ),
        ),
      ),
    );
  }
}
