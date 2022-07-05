import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:student_app/models/student.dart';

class StudentsModel extends ChangeNotifier {
  final Box<Student> _box = Hive.box('studentsDB');
  List<Student> _studentsList = [];
  StudentsModel() {
    _getStudents();
  }

  get studentsList => _studentsList;

  add(Student student) {
    _box.add(student);
    _getStudents();
    notifyListeners();
  }

  update(var key, Student student) {
    _box.put(key, student);
    _getStudents();
    notifyListeners();
  }

  delete(Student student) {
    student.delete();
    _getStudents();
    notifyListeners();
  }

  _getStudents() {
    _studentsList = _box.values.toList();
  }
}
