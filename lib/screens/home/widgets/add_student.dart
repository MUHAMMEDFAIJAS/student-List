import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_3/db/functions/dbfunctions.dart';
import 'package:hive_3/model/datamodel.dart';
import 'package:image_picker/image_picker.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();

  File? _imageFile;

  Future _pickImgGallery(source) async {
    final returnImg = await ImagePicker().pickImage(source: source);

    if (returnImg == null) {
      return;
    }
    setState(() {
      _imageFile = File(returnImg.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {
                    _pickImgGallery(ImageSource.camera);
                  },
                  child: const Icon(
                    Icons.camera,
                    color: Colors.lightBlue,
                    size: 100,
                  )),
              ElevatedButton(
                  onPressed: () {
                    _pickImgGallery(ImageSource.gallery);
                  },
                  child: const Icon(
                    Icons.image,
                    color: Colors.lightBlue,
                    size: 100,
                  ))
            ],
          ),
          _imageFile != null
              ? Image.file(
                  _imageFile!,
                  height: 170,
                  width: 200,
                )
              : const SizedBox(
                  height: 40,
                ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter name';
                    } else {
                      return null;
                    }
                  },
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'name',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                        validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter age';
                    } else {
                      return null;
                    }
                  },
                  
                  controller: _ageController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'age',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                        validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter address';
                    } else {
                      return null;
                    }
                  },
                  controller: _addressController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'address'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addButtonClicked();
                         Navigator.pop(context);
                      }
                      
                     
                    },
                    child: const Text('ADD STUDENT'))
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> addButtonClicked() async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final address = _addressController.text.trim();

    if (name.isEmpty || age.isEmpty || address.isEmpty) {
      return;
    }

    final student = StudentModel(
      name: name,
      age: age,
      imagePath: _imageFile?.path,
      address: address,
    );

    if (_imageFile != null) {
      student.imagePath = _imageFile!.path;
    }
    addStudent(student);
  }
}
