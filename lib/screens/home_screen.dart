import 'package:provider/provider.dart';
import 'package:student_app/models/students_model.dart';
import 'package:student_app/screens/add_student_screen.dart';
import 'package:student_app/screens/search_screen.dart';
import 'package:student_app/screens/view_details_screen.dart';
import 'package:student_app/util.dart';
import 'package:student_app/widgets/conform_dialog.dart';
import '/models/student.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdfdfdf),
      appBar: AppBar(
        title: const Text('Students'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {
              showSearch(context: context, delegate: SearchScreen());
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  const ScreenAddStudent(action: 'add', data: null),
            ),
          );
        },
        tooltip: 'Add student',
        child: const Icon(Icons.add),
      ),
      body: Consumer<StudentsModel>(
        builder: (context, students, _) {
          if (students.studentsList.isEmpty) {
            return Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.person, color: Colors.black54),
                  SizedBox(width: 8),
                  Text(
                    "No students",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 18),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
              itemBuilder: (context, index) {
                Student curStudent = students.studentsList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            StudentDetailsScreen(student: curStudent),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    margin: const EdgeInsets.all(0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: CircleAvatar(
                        backgroundImage:
                            Util.getAvatharImage(curStudent.imageString),
                      ),
                      title: Text(
                        curStudent.name,
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => ConformDialog(
                                      title:
                                          'Are you sure to delete this student',
                                      onConform: () {
                                        students.delete(curStudent);
                                        Navigator.pop(context);
                                      },
                                    ));
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  ),
                );
              },
              itemCount: students.studentsList.length);
        },
      ),
    );
  }
}
