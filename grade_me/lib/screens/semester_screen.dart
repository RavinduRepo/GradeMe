import 'package:flutter/material.dart';
import 'package:grade_me/models/course_model.dart';
import 'package:grade_me/models/semester_models.dart';
import 'package:grade_me/widgets/semester_details.dart';

class SemesterPage extends StatefulWidget {
  final Semester semester;
  final VoidCallback onSave;

  const SemesterPage({super.key, required this.semester, required this.onSave});

  @override
  State<SemesterPage> createState() => _SemesterPageState();
}

class _SemesterPageState extends State<SemesterPage> {
  void addCourse() {
    setState(() {
      widget.semester.courses.add(Course());
      widget.onSave();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semester Details'),
      ),
      body: SemesterDetails(
        semester: widget.semester,
        onSave: widget.onSave,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addCourse,
        child: const Icon(Icons.add),
      ),
    );
  }
}
