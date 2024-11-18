import 'dart:async';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is the largest planet in our solar system?",
      "options": ["Earth", "Mars", "Jupiter", "Saturn"],
      "answer": "Jupiter"
    },
    {
      "question": "Who wrote 'To Kill a Mockingbird'?",
      "options": ["Harper Lee", "Mark Twain", "J.K. Rowling", "Ernest Hemingway"],
      "answer": "Harper Lee"
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
      appBar: AppBar(title: const Text("Quiz")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Timer: $timer", style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          Text(
            question['question'],
            style: const TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ...question['options'].map((option) {
            return ElevatedButton(
              onPressed: () => _checkAnswer(option),
              child: Text(option),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
