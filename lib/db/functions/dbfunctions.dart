import 'package:flutter/material.dart';
import 'package:hive_3/model/datamodel.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);



Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.add(value);
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('Student_db');
  studentListNotifier.value.clear();

  studentListNotifier.value.addAll(studentDB.values);
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudents(int index) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.deleteAt(index);

  studentListNotifier.notifyListeners();
  getAllStudents();
}

Future<void> editStudents(index, StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);

  await studentDB.putAt(index, value);
  studentListNotifier.notifyListeners();
  getAllStudents();
}
Future<void> searchStudents(String searching) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.value.clear();

  final filteredStudents = studentDB.values
      .where((student) =>
          student.name.toLowerCase().contains(searching.toLowerCase()) 

          ).toList();

  studentListNotifier.value.addAll(filteredStudents);
  studentListNotifier.notifyListeners();
}
