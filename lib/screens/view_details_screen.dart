import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/controllers/students_controller.dart';
import 'package:student_app/util.dart';
import 'package:student_app/widgets/conform_dialog.dart';
import '../models/student.dart';
import 'add_student_screen.dart';

class StudentDetailsScreen extends StatelessWidget {
  final Student student;
  const StudentDetailsScreen({required this.student, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(fontSize: 16);
    return Scaffold(
      backgroundColor: const Color(0xFFDFDFDF),
      appBar: AppBar(
        title: const Text('Student info'),
        centerTitle: true,
        actions: [
          IconButton(
              tooltip: 'Edit',
              onPressed: () {
                Get.to(() => ScreenAddStudent(
                      action: 'edit',
                      data: student,
                    ));
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              tooltip: 'Delete',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => ConformDialog(
                        title: 'Are you sure',
                        onConform: () {
                          StudentsController studentsController = Get.find();
                          studentsController.deleteStudent(student);
                          Get.until((route) => Get.currentRoute == '/home');
                        }));
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: ListView(
        children: [
          Card(
            elevation: 2,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                height: 230,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage:
                            Util.getAvatharImage(student.imageString),
                      ),
                      Text(
                        student.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ]),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 2,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Details',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Name  :  ${student.name}', style: textStyle),
                    const SizedBox(height: 15),
                    Text('Age  :  ${student.age}', style: textStyle),
                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Address  :  ', style: textStyle),
                        Text(student.address, style: textStyle)
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text('Phone  :  ${student.phone}', style: textStyle),
                    const SizedBox(height: 15),
                    if (student.email.isNotEmpty)
                      Text('E-mail :  ${student.email}', style: textStyle),
                    const SizedBox(height: 15),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
