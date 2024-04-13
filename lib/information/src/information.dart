import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      insetPadding: EdgeInsets.fromLTRB(
        size.width * 0.1,
        size.height * 0.1,
        size.width * 0.1,
        size.height * 0.1,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton(
            alignment: Alignment.centerRight,
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(Icons.clear),
          ),
          const Text(
            'About the Game',
          ),
          const Text(
            'Schrodle is a Wordle-based game inspired by the '
            "Schrödinger's Cat thought experiment."
          ),
          const Text(
            'The game works exactly like Wordle, but with a twist.'
          ),
          const Text(
            'Like Wordle, the player is tasked with guessing the daily word, '
            'which we call the "target." However, in addition to the target, '
            'there is a secondary word, called the "impostor." Whenever a '
            'guess is made, the guess has a 50% chance of being validated '
            'against either the target or the impostor. Therefore, if the '
            'impostor is used to validate the guess, letters can be marked as '
            'present in the target word when, in fact, the are absent. Letters '
            'may be simultaneously market present and not present. Thus, the '
            "Schrödinger's Cat thought experiment is, in essence, upheld."
          ),
        ],
      ),
    );
  }
}
