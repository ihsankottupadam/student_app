import 'package:hive/hive.dart';
import 'package:student_app/models/student.dart';

class Boxes {
  static Box<Student> getStudents() {
    return Hive.box('studentsDB');
  }
}
