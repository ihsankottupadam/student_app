import 'package:get/get.dart';
import 'package:student_app/controllers/students_controller.dart';
import 'package:student_app/screens/add_student_screen.dart';
import 'package:student_app/screens/search_screen.dart';
import 'package:student_app/screens/view_details_screen.dart';
import 'package:student_app/util.dart';
import 'package:student_app/widgets/conform_dialog.dart';
import '/models/student.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final controller = Get.put(StudentsController());
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
          Get.to(() => const ScreenAddStudent(action: 'add', data: null));
        },
        tooltip: 'Add student',
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<StudentsController>(
        builder: (studentsController) {
          if (studentsController.studentsList.isEmpty) {
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
                Student curStudent = studentsController.studentsList[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => StudentDetailsScreen(student: curStudent));
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
                                        studentsController
                                            .deleteStudent(curStudent);
                                        Get.back();
                                      },
                                    ));
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  ),
                );
              },
              itemCount: studentsController.studentsList.length);
        },
      ),
    );
  }
}
