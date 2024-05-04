import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Results extends StatelessWidget {
  const Results({required this.results, super.key});

  final String results;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: AlertDialog(
        content: Column(  
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                alignment: Alignment.centerRight,
                onPressed: () => Navigator.maybePop(context),
                icon: const Icon(Icons.clear),
              ),
            ),
            const Image(
              width: 150,
              height: 150,
              image: AssetImage('images/schrodle-light.png'),
            ),
            SizedBox(height: 10),
            const Text(
              'Thank you for playing Schrodle!',
              style: TextStyle(
                fontSize: 17.5,
              ),
            ),
            SizedBox(height: 10),
            TextButton.icon(
              label: const Text('Copy results'),
              icon: const Icon(Icons.copy),
              onPressed: () => Clipboard.setData(ClipboardData(text: results)),
            ),
          ],
        ),
      ),
    );
  }
}
