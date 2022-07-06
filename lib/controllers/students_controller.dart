import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:student_app/models/student.dart';

class StudentsController extends GetxController {
  final Box<Student> _box = Hive.box('studentsDB');
  List<Student> _studentsList = [];
  StudentsController() {
    _getStudents();
  }

  get studentsList => _studentsList;

  addStudent(Student student) {
    _box.add(student);
    _getStudents();
    update();
  }

  updateStudent(var key, Student student) {
    _box.put(key, student);
    _getStudents();
    update();
  }

  deleteStudent(Student student) {
    student.delete();
    _getStudents();
    update();
  }

  _getStudents() {
    _studentsList = _box.values.toList();
  }
}
