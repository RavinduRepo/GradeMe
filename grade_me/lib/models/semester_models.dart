
import 'course_model.dart';

class Semester {
  List<Course> courses;

  Semester({this.courses = const []}); // Default constructor

  double get totalCredits =>
      courses.fold(0, (sum, course) => sum + course.credits);

  double calculateSemesterGPA() {
    if (courses.isEmpty) return 0.0;
    double totalPoints = 0;
    for (var course in courses) {
      totalPoints += course.gradePoints * course.credits;
    }
    return totalCredits > 0 ? totalPoints / totalCredits : 0.0;
  }

  Map<String, dynamic> toJson() {
    return {
      'courses': courses.map((e) => e.toJson()).toList(),
    };
  }

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      courses:
          (json['courses'] as List).map((e) => Course.fromJson(e)).toList(),
    );
  }
}