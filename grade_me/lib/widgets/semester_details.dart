import 'package:flutter/material.dart';
import 'package:grade_me/main.dart';
import 'package:grade_me/models/semester_models.dart';

class SemesterDetails extends StatelessWidget {
  final Semester semester;
  final VoidCallback onSave;

  const SemesterDetails(
      {super.key, required this.semester, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: semester.courses.length,
      itemBuilder: (context, index) {
        final course = semester.courses[index];
        return ListTile(
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              semester.courses.removeAt(index);
              onSave();
            },
          ),
          // course name
          title: TextField(
            controller: TextEditingController.fromValue(
              TextEditingValue(
                text: course.name,
                selection: TextSelection.collapsed(offset: course.name.length),
              ),
            ),
            onChanged: (value) {
              course.name = value;
              onSave();
            },
            decoration: InputDecoration(hintText: 'Course ${index + 1} Name'),
          ),
          subtitle: Row(
            children: [
              DropdownButton<String>(
                value: course.grade,
                onChanged: (value) {
                  course.grade = value ?? 'A';
                  onSave();
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
                // course credits
                child: TextField(
                  controller:
                      TextEditingController(text: course.credits.toString()),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    course.credits = double.tryParse(value) ?? 3.0;
                    onSave();
                  },
                  decoration: const InputDecoration(hintText: 'Credits'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
