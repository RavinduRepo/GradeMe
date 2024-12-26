import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grade_me/models/semester_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'semester_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Semester> semesters = [];

  @override
  void initState() {
    super.initState();
    _loadSemesters();
  }

  Future<void> _loadSemesters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString('semesters');
    if (savedData != null) {
      List<dynamic> decodedData = jsonDecode(savedData);
      setState(() {
        semesters = decodedData.map((e) => Semester.fromJson(e)).toList();
      });
    }
  }

  Future<void> _saveSemesters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> encodedData =
        semesters.map((e) => e.toJson()).toList();
    await prefs.setString('semesters', jsonEncode(encodedData));
  }

  double calculateTotalGPA() {
    if (semesters.isEmpty) return 0.0;
    double totalPoints = 0;
    double totalCredits = 0;
    for (var semester in semesters) {
      totalPoints += semester.calculateSemesterGPA() * semester.totalCredits;
      totalCredits += semester.totalCredits;
    }
    return totalCredits > 0 ? totalPoints / totalCredits : 0.0;
  }

  void addSemester() {
    setState(() {
      semesters.add(Semester());
    });
    _saveSemesters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPA Calculator'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total GPA: ${calculateTotalGPA().toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: semesters.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Semester ${index + 1}'),
                  trailing: Text(
                      'GPA: ${semesters[index].calculateSemesterGPA().toStringAsFixed(2)}'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SemesterPage(
                        semester: semesters[index],
                        onSave: _saveSemesters,
                      ),
                    ),
                  ).then((_) => setState(() {})),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addSemester,
        child: const Icon(Icons.add),
      ),
    );
  }
}
