import 'dart:async';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      "question": "1:What is the largest planet in our solar system?",
      "options": ["Earth", "Mars", "Jupiter", "Saturn"],
      "answer": "Jupiter"
    },
    {
      "question": "2:Who wrote 'To Kill a Mockingbird'?",
      "options": [
        "Harper Lee",
        "Mark Twain",
        "J.K. Rowling",
        "Ernest Hemingway"
      ],
      "answer": "Harper Lee"
    },
    {
      "question": "3:What is the capital of France?",
      "options": ["Berlin", "Madrid", "Paris", "Rome"],
      "answer": "Paris"
    },
    {
      "question": "4:Which element has the chemical symbol 'O'?",
      "options": ["Oxygen", "Gold", "Osmium", "Oganesson"],
      "answer": "Oxygen"
    },
    {
      "question": "5:What is the smallest unit of life?",
      "options": ["Atom", "Molecule", "Cell", "Organ"],
      "answer": "Cell"
    },
    {
      "question": "6:What is the freezing point of water?",
      "options": ["0°C", "32°C", "-100°C", "100°C"],
      "answer": "0°C"
    },
  ];

  int currentQuestionIndex = 0;
  int score = 0;
  int timer = 15;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (this.timer > 0) {
          this.timer--;
        } else {
          _nextQuestion();
        }
      });
    });
  }

  void _nextQuestion() {
    _timer?.cancel();
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        timer = 15;
        _startTimer();
      });
    } else {
      Navigator.pushReplacementNamed(
        context,
        '/results',
        arguments: score,
      );
    }
  }

  void _checkAnswer(String selectedOption) {
    if (selectedOption == questions[currentQuestionIndex]['answer']) {
      score++;
    }
    _nextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: timer <= 5 ? Colors.red : Colors.white,
              child: Text(
                "$timer",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: timer <= 5 ? Colors.white : Colors.blueAccent,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              question['question'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 4,
                    color: Colors.black26,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ...question['options'].map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () => _checkAnswer(option),
                  child: Text(
                    option,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1E88E5),
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
