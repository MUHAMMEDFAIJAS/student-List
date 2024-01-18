import 'package:flutter/material.dart';
import 'package:hive_3/db/functions/dbfunctions.dart';
import 'package:hive_3/screens/home/widgets/listAdd.dart';
import 'package:hive_3/screens/home/widgets/list_student.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllStudents();

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ListAddStudent()),
             );
            },
      child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: ListStudent()),
          ],
        ),
      ),
    );
  }
}
