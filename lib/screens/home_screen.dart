import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app/database/box.dart';
import 'package:student_app/screens/add_student_screen.dart';
import 'package:student_app/screens/search_screen.dart';
import 'package:student_app/screens/view_details_screen.dart';
import 'package:student_app/util.dart';
import '/models/student.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

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
      body: ValueListenableBuilder(
        valueListenable: Boxes.getStudents().listenable(),
        builder: (BuildContext ctx, Box<Student> box, Widget? child) {
          if (box.values.isEmpty) {
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
                Student curStudent = box.getAt(index)!;
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
                            _confirmDelete(context, curStudent);
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  ),
                );
              },
              itemCount: box.length);
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, Student curStudent) {
    showDialog(
        context: context,
        builder: (context) => Theme(
              data: ThemeData(primaryColor: Colors.blue),
              child: AlertDialog(
                content: const Text(
                  'Are you sure to delete this student? ',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('No')),
                  TextButton(
                      onPressed: () {
                        curStudent.delete();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Yes'))
                ],
              ),
            ));
  }
}
