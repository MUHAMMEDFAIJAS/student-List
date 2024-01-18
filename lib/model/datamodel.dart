import 'package:hive/hive.dart';
part 'datamodel.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String age;

  @HiveField(2)
  String? imagePath;

  @HiveField(3)
  String address;


  StudentModel(
      {required this.name,
      required this.age,
      this.imagePath,
      required this.address,
      
      });
}
