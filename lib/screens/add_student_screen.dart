import 'package:flutter/material.dart';
import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app/database/box.dart';
import 'package:student_app/models/student.dart';
import 'package:student_app/screens/home_screen.dart';
import 'package:student_app/util.dart';

class ScreenAddStudent extends StatefulWidget {
  const ScreenAddStudent({required this.action, required this.data, Key? key})
      : super(key: key);
  final String action;
  final Student? data;
  @override
  State<ScreenAddStudent> createState() => _ScreenAddStudentState();
}

class _ScreenAddStudentState extends State<ScreenAddStudent> {
  String? imageString;
  String? name;
  String? age;
  String? address;
  String? phone;
  String? email;
  File? imageFile;
  Student? curStudent;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (widget.action == 'edit') {
      curStudent = widget.data;
      imageString = curStudent?.imageString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.action == 'add' ? 'Add student' : 'Edit student'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              _save();
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () => _showImaePicker(),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.transparent,
                  backgroundImage: Util.getAvatharImage(imageString),
                ),
              ),
              TextButton(
                onPressed: () => _showImaePicker(),
                child: Text(
                  'Choose photo',
                  style: TextStyle(
                    color: Colors.blue[400],
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
        ),
        Theme(
          data: ThemeData(primarySwatch: Colors.blue),
          child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        icon: Icon(Icons.person),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Enter name';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        name = val;
                      },
                      initialValue: curStudent?.name,
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Age',
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        ),
                        initialValue: curStudent?.age,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter age';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          age = val;
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            labelText: 'Address',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                          ),
                          initialValue: curStudent?.address,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Enter Address';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            address = val;
                          }),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                          icon: Icon(Icons.phone),
                          hintText: '10 digit mobile number',
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        ),
                        initialValue: curStudent?.phone,
                        validator: (val) {
                          if (val != null && val.length < 10) {
                            return 'Enter valid mobile number';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          phone = val;
                        }),
                    const SizedBox(height: 15),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        icon: Icon(Icons.email),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      ),
                      initialValue: curStudent?.email,
                      onSaved: (val) {
                        email = val;
                      },
                    ),
                  ],
                ),
              )),
        )
      ]),
    );
  }

  _showImaePicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            height: 150,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Pick from',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _choosePhoto(ImageSource.camera);
                      },
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Camera')),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _choosePhoto(ImageSource.gallery);
                      },
                      icon: const Icon(Icons.image),
                      label: const Text('Gallery')),
                )
              ],
            ),
          );
        });
  }

  _choosePhoto(source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image == null) return;
    imageFile = File(image.path);
    setState(() {
      imageString = Util.imageToString(imageFile);
    });
  }

  _save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Box<Student> studentBox = Boxes.getStudents();
      Student student = Student(
          name: name!,
          age: age!,
          address: address!,
          phone: phone!,
          email: email ?? '',
          imageString: imageString ?? '');

      if (widget.action == 'edit') {
        studentBox.put(widget.data!.key, student);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return const HomeScreen();
        }), (route) => false);
      } else {
        studentBox.add(student);
        Navigator.of(context).pop();
      }
    }
  }
}
