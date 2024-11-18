import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int score = ModalRoute.of(context)?.settings.arguments as int;

    _saveHighScore(score);

    return Scaffold(
      appBar: AppBar(title: const Text("Results")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your Score: $score", style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/quiz');
              },
              child: const Text("Play Again"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Home"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveHighScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    final highScore = prefs.getInt('high_score') ?? 0;
    if (score > highScore) {
      prefs.setInt('high_score', score);
    }
  }
}
