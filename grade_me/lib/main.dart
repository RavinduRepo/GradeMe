import 'package:flutter/material.dart';

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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Semester> semesters = [];

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
                  trailing: Text('GPA: ${semesters[index].calculateSemesterGPA().toStringAsFixed(2)}'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SemesterPage(
                        semester: semesters[index],
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

class Semester {
  List<Course> courses = [];

  double get totalCredits => courses.fold(0, (sum, course) => sum + course.credits);

  double calculateSemesterGPA() {
    if (courses.isEmpty) return 0.0;
    double totalPoints = 0;
    for (var course in courses) {
      totalPoints += course.gradePoints * course.credits;
    }
    return totalCredits > 0 ? totalPoints / totalCredits : 0.0;
  }
}

class Course {
  String name;
  String grade;
  double credits;

  Course({
    this.name = '',
    this.grade = 'A',
    this.credits = 3.0,
  });

  double get gradePoints => gradeToPoints[grade] ?? 0.0;
}

Map<String, double> gradeToPoints = {
  'A+': 4.0,
  'A': 4.0,
  'B+': 3.5,
  'B': 3.0,
  'C+': 2.5,
  'C': 2.0,
  'D': 1.0,
  'F': 0.0,
};

class SemesterPage extends StatefulWidget {
  final Semester semester;

  const SemesterPage({super.key, required this.semester});

  @override
  State<SemesterPage> createState() => _SemesterPageState();
}

class _SemesterPageState extends State<SemesterPage> {
  void addCourse() {
    setState(() {
      widget.semester.courses.add(Course());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semester Details'),
      ),
      body: ListView.builder(
        itemCount: widget.semester.courses.length,
        itemBuilder: (context, index) {
          final course = widget.semester.courses[index];
          return ListTile(
            title: TextField(
              onChanged: (value) => course.name = value,
              decoration: InputDecoration(hintText: 'Course ${index + 1} Name'),
            ),
            subtitle: Row(
              children: [
                DropdownButton<String>(
                  value: course.grade,
                  onChanged: (value) {
                    setState(() {
                      course.grade = value ?? 'A';
                    });
                  },
                  items: gradeToPoints.keys.map((grade) {
                    return DropdownMenuItem(
                      value: grade,
                      child: Text(grade),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) => course.credits = double.tryParse(value) ?? 3.0,
                    decoration: const InputDecoration(hintText: 'Credits'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addCourse,
        child: const Icon(Icons.add),
      ),
    );
  }
}
