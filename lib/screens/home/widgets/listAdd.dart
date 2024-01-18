import 'package:flutter/material.dart';
import 'package:hive_3/screens/home/widgets/add_student.dart';

class ListAddStudent extends StatelessWidget {
  const ListAddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: AddStudent()),
        ],
      ),
    );
  }
}
