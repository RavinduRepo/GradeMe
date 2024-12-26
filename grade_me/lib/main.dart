import 'package:flutter/material.dart';
import 'package:grade_me/screens/home_screen.dart';

void main() {
  runApp(const GPACalculatorApp());
}

class GPACalculatorApp extends StatelessWidget {
  const GPACalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPA Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}

Map<String, double> gradeToPoints = {
  'A+': 4.0,
  'A': 4.0,
  'A-': 3.7,
  'B+': 3.3,
  'B': 3.0,
  'B-': 2.7,
  'C+': 2.3,
  'C': 2.0,
  'C-': 1.7,
  'D+': 0.3,
  'D': 1.0,
  'E': 0.0,
};
