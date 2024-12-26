import 'package:grade_me/main.dart';

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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'grade': grade,
      'credits': credits,
    };
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      name: json['name'],
      grade: json['grade'],
      credits: json['credits'],
    );
  }
}