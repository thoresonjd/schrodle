import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Results extends StatelessWidget {
  const Results({required this.results, super.key});

  final String results;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: [
          const Text('Thank you for playing Schrodle!'),
          TextButton(
            child: const Text('Copy results'),
            onPressed: () => Clipboard.setData(
              ClipboardData(
                text: results,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
