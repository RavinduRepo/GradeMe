import 'package:flutter/material.dart';
import 'package:grade_me/main.dart';
import 'package:grade_me/models/semester_models.dart';

class SemesterDetails extends StatefulWidget {
  final Semester semester;
  final VoidCallback onSave;

  const SemesterDetails(
      {super.key, required this.semester, required this.onSave});

  @override
  _SemesterDetailsState createState() => _SemesterDetailsState();
}

class _SemesterDetailsState extends State<SemesterDetails> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.semester.courses.length,
      itemBuilder: (context, index) {
        final course = widget.semester.courses[index];
        return ListTile(
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                widget.semester.courses.removeAt(index);
                widget.onSave();
              });
            },
          ),
          title: TextField(
            controller: TextEditingController.fromValue(
              TextEditingValue(
                text: course.name,
                selection: TextSelection.collapsed(offset: course.name.length),
              ),
            ),
            onChanged: (value) {
              course.name = value;
              widget.onSave();
            },
            decoration: InputDecoration(hintText: 'Course ${index + 1} Name'),
          ),
          subtitle: Row(
            children: [
              DropdownButton<String>(
                value: course.grade,
                onChanged: (value) {
                  setState(() {
                    course.grade = value ?? 'A';
                    widget.onSave();
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
                  controller:
                      TextEditingController(text: course.credits.toString()),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      course.credits = double.tryParse(value) ?? 3.0;
                      widget.onSave();
                    });
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
