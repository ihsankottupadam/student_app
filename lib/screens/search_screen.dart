import 'package:flutter/material.dart';
import 'package:student_app/database/box.dart';
import 'package:student_app/models/student.dart';
import 'package:student_app/screens/view_details_screen.dart';
import 'package:student_app/util.dart';

class SearchScreen extends SearchDelegate {
  SearchScreen() : super(searchFieldLabel: 'Search student');
  List<Student> students = Boxes.getStudents().values.toList();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: (() {
            query = '';
          }),
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Student> matchQuery = [];
    for (var item in students) {
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return Container(
      color: const Color(0xffdfdfdf),
      child: ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          Student curStudent = matchQuery[index];
          return InkWell(
            onTap: () {
              close(context, null);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StudentDetailsScreen(
                    student: curStudent,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 2,
              margin: const EdgeInsets.all(0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                leading: CircleAvatar(
                  backgroundImage: Util.getAvatharImage(curStudent.imageString),
                ),
                title: Text(curStudent.name),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Student> matchQuery = [];
    for (var item in students) {
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return Container(
      color: const Color(0xffdfdfdf),
      child: ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          Student curStudent = matchQuery[index];
          return InkWell(
            onTap: () {
              close(context, null);
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
                  backgroundImage: Util.getAvatharImage(curStudent.imageString),
                ),
                title: Text(curStudent.name),
              ),
            ),
          );
        },
      ),
    );
  }
}
