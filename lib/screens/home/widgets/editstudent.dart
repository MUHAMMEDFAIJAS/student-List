import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_3/db/functions/dbfunctions.dart';
import 'package:hive_3/model/datamodel.dart';
import 'package:image_picker/image_picker.dart';

class EditStudent extends StatefulWidget {
  final int index;

  const EditStudent({Key? key, required this.index}) : super(key: key);

  @override
  EditStudentState createState() => EditStudentState();
}

class EditStudentState extends State<EditStudent> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();

  File? _imageFile;

  @override
  void initState() {
    super.initState();

    final student = studentListNotifier.value[widget.index];
    _nameController.text = student.name;
    _ageController.text = student.age;
    _addressController.text = student.address;

    if (student.imagePath != null) {
      _imageFile = File(student.imagePath!);
    }
  }

  Future<void> _pickImage() async {
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      setState(() {
        _imageFile = File(PickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Name',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Age',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  
                  
                   hintText: ' Enter Address'),
            ),
            ElevatedButton(
              onPressed: () {
                _pickImage();
              },
              child: const Text('pick image'),
            ),
            _imageFile != null
                ? Image.file(
                    _imageFile!,
                    height: 100,
                  )
                : const SizedBox(
                    height: 20,
                  ),
            ElevatedButton(
              onPressed: () {
                updateButtonClicked();
              },
              child: const Text('UPDATE STUDENT'),
            ),
          ],
        ),
      ),
    );
  }

  void updateButtonClicked() {
    final updatedName = _nameController.text.trim();
    final updatedAge = _ageController.text.trim();
    final updatedAddress = _addressController.text.trim();

    if (updatedName.isEmpty || updatedAge.isEmpty || updatedAddress.isEmpty) {
      return ;
    }

    final updatedStudent =
        StudentModel(name: updatedName, age: updatedAge, address: updatedAddress);

    if (_imageFile != null) {
      updatedStudent.imagePath = _imageFile!.path;
    }

    editStudents(widget.index, updatedStudent);

    Navigator.pop(context);
  }
}
