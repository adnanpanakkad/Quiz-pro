import 'package:flutter/material.dart';
import 'package:quiz_pro/screens/home.dart';
import 'package:quiz_pro/screens/quiz_screen.dart';
import 'package:quiz_pro/screens/result_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Pro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/quiz': (context) => QuizScreen(),
        '/results': (context) => ResultsScreen(),
      },
    );
  }
}
