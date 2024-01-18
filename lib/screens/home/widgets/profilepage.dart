import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_3/model/datamodel.dart';

class ProfilePage extends StatelessWidget {
  final StudentModel student;

  const ProfilePage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Student Profile'),backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Container(
          height: 600,
          width: 300,
          color: Colors.deepPurple,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100,
                
                

      backgroundImage: student.imagePath != null
      ? FileImage(File(student.imagePath!))
      : const NetworkImage(
        'https://tse2.mm.bing.net/th?id=OIP.x7X2oAehk5M9IvGwO_K0PgHaHa&pid=Api&P=0&h=180'
      ) as ImageProvider,
),
              const SizedBox(height: 50),
              Text(
                'Name: ${student.name}',
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Text(
                'Age: ${student.age}',
                style: const TextStyle(fontSize: 20,color: Colors.white),
              ),
              const SizedBox(height: 20),

              Text(
                'address: ${student.address}',

                style:  const TextStyle(fontSize: 20,color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
