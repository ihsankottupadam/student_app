import 'package:hive/hive.dart';

part 'student.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String age;

  @HiveField(2)
  final String address;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final String imageString;
  Student(
      {required this.name,
      required this.age,
      required this.address,
      required this.phone,
      required this.email,
      required this.imageString});
}
